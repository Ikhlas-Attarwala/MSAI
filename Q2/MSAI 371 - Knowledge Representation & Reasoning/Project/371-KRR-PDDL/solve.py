import requests, json, os, sys
from pprint import PrettyPrinter

pprint = PrettyPrinter().pprint
debug = True

with open('templates.json') as f:
    templates = json.load(f)

def parse_action_name(name):
    action = name[1:-1].split()
    action_name, args = action[0], action[1:]
    template = templates[action_name]
    text = template.format(*args)
    return text

def convert_file_to_ascii(filename):
    with open(filename) as f:
        string = f.read()
    ascii_version = "".join(c for c in string if ord(c) < 128)
    with open(filename, 'w', encoding='ascii') as f:
        f.write(ascii_version)

def convert_pddl_to_ascii():
    filenames = os.listdir()
    for filename in filenames:
        if filename[-4:] == 'pddl':
            convert_to_ascii(filename)

def solve(domain, problem):
    data = {'domain': open(domain).read(),
            'problem': open(problem).read()}

    r = requests.post('http://solver.planning.domains/solve', data=data)
    #print(r.text)
    try:
        actions = json.loads(r.text)['result']['plan']
    except KeyError:
        print("I couldn't establish guilt to the level I wanted!")
        if debug:
            pprint(r.text)
        sys.exit(0)
    return actions

def main():
    try:
        domain, problem = sys.argv[1], sys.argv[2]
    except IndexError:
        domain, problem = 'domain1.pddl', 'problem5_solvable_love_triangle.pddl'
    
    actions = solve(domain, problem)
    for action in actions:
        name = action['name']
        print(parse_action_name(name))

if __name__ == '__main__':
    main()
