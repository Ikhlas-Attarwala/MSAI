#lang dssl2
import cons


def anyfs(g, start):
    let to_do = Container()
    let seen = [ False; g.len() ]
    
    to_do.add(start)
    seen[start] = True
    
    while not to_do.empty?():
        let v = to_do.remove()
        let succs = g.succs(v)
        while cons?(succs):           #while there are successors to look at, succs.car is one, then move on
            let u = succs.car
            if not seen[u]:           #if we haven't seen it, we mark we've seen it and say true, but also where we got there from
                seen[u] = v
                to_do.add(u)
            succs = succs.cdr
    seen

def extract_path(seen, end):
    def loops(v):
        if seen[v] == True:
            cons(v, nil())
        else:
            cons(v, loop(seen[v]))
    Cons.rev(loop(end))

# this was all review