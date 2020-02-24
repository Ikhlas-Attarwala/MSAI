#lang dssl2
import cons

# represent the set {2, 3, 5}
let v = [ 6, 5, 4, 3 ]

## try typing :
# v
# v.len()
# indexing is constant time
# v[0]
# v[1]
# v[2] = 'hello'
# v
# [ False ; 6]
##

#for e in v:
#    if e == 5:
#        return True
#    return False

# graph of 8 vertices

let v2 = [ False, False, True, True, False, True, False, False ]

# ====================================================
# ====================================================

class Posn:
    let x: num?
    let y: num?
    
    def __init__(self, x, y):
        self.x = x
        self.y = y

## try typing :
# let p = Posn(3, 4)
# p
# p.x « is an error
# p.y « is also an error
# « you have to use a method to get the values!
##

    def get_x(self):
        self.x
    
    def get_y(self):
        self.y

## try typing:
# p.get_x()
# p.get_y()
##

    def origin?(self):
        self.x == 0 and self.y == 0
    
    def add_to_x(self, change):
        self.x = self.x + change

##
# p.origin?() « should return false
# p
# p.get_x()
# p.add_to_x(10)
# p.get_x()
##

# ====================================================
# ====================================================

interface DIGRAPH:
    def len(self) -> nat?
    # succs : nat? -> ListC[nat?]
    def succs(self, src: nat?) -> Cons.list?

# make a class that "satisfies" the interface

class AdjListDiGraph (DIGRAPH):
    let lists: VecC[Cons.list?]
    
    def __init__(self, len: nat?):
        self.lists = [ nil() ; len ]
    
    def len(self):
        self.lists.len()
    
    def succs(self, src):
        self.lists[src]

##
# let g = AdjListDiGraph(8)
# g
##


# template!
#    def has_edge?(self, src: nat?, dst: nat?) -> bool?:
#        def loop(succs: Cons.list?) -> bool?:
#            if cons?(succs):
#                succs.car
#                loop(succs.cdr)
#            else:
#                pass
#        self.lists[src]

    def has_edge?(self, src: nat?, dst: nat?) -> bool?:
        def loop(succs: Cons.list?) -> bool?:
            if cons?(succs):
                if dst == succs.car: True
                else: loop(succs.cdr)
            else:
                pass
        loop(self.lists[src])

# template!
#    def has_edge_iter?(self, src: nat?, dst: nat?) -> bool?:
#        ...
#        while cons?(succs):
#            ... succs.car ... succs.cdr ...
#            succs = succs.cdr
#        ...

    def has_edge_iter?(self, src: nat?, dst: nat?) -> bool?:
        let succs = self.lists[src]
        while cons?(succs):
            if succs.car == dst:
                return True
            #else: pass    «don't need else statements!
            succs = succs.cdr
        False
# can also do:
#    def has_edge_iter?(self, src: nat?, dst: nat?) -> bool?:
#        let succs = self.lists[src]
#        let result = False
#        while cons?(succs):
#            if succs.car == dst:
#                result = True
#            #else: pass    «don't need else statements!
#            succs = succs.cdr
#        result

    def add_edge(self, src: nat?, dst: nat?) -> VoidC:
        if not self.has_edge?(src, dst):
            self.lists[src] = cons(dst, self.lists[src])

def GRAPH_EX0():
    let g = AdjListDiGraph(7)
    g.add_edge(0, 1)
    g.add_edge(0, 2)
    g.add_edge(0, 3)
    g.add_edge(1, 3)
    g.add_edge(1, 0)
    g.add_edge(1, 4)
    g.add_edge(2, 4)
    g.add_edge(2, 0)
    g.add_edge(3, 4)
    g.add_edge(3, 1)
    g.add_edge(3, 2)
    g.add_edge(4, 5)
    g.add_edge(4, 4)
    g.add_edge(6, 3)
    g.add_edge(6, 4)
    g
    
test 'hard-coded graph is correct':
    let g = GRAPH_EX0()
    assert_eq g.len(), 7
    assert_eq g.succs(2), cons(0, cons(4, nil()))

def mk_adj_vec_graph(vecs: VecC) -> AdjListDiGraph?:
    let result = AdjListDiGraph(vecs.len())
    for v, succs in vecs:
        for u in succs:
            result.add_edge(v, u)
    result

# O(V + dE)
let GRAPH_EX1 = mk_adj_vec_graph([
    [1, 2, 3],
    [3, 0, 4],
    [4, 0],
    [4, 1, 2],
    [5, 4],
    [],
    [3, 4]
    ])

# O(V + E)

let SearchTreeC = VecC[OrC(nat?, bool?)]

# dfs : DIGRAPH nat? -> SearchTreeC
# Searches a graph starting at the given vertex
#
# Strategy: generative recursion
# standard depth-first-search
def dfs(a_graph: DIGRAPH!, start_node: nat?) -> SearchTreeC:
    let result: SearchTreeC = [ False; a_graph.len() ]
    def visit(node: nat?) -> VoidC:
        def each(succ: nat?) -> VoidC:
            if not result[succ]:
                result[succ] = node
                visit(succ)
        Cons.foreach(each, a_graph.succs(node))
    result[start_node] = True
    visit(start_node)
    result

##
# dfs(GRAPH_EX1, 0)
# dfs(GRAPH_EX1, 6)
##

def route_exists?(a_graph: DIGRAPH!, src: nat?, dst: nat?) -> bool?:
    not not dfs(a_graph, src)[dst]

interface CONTAINER[X]:
    def empty?(self) -> bool?
    def add(self, element: X) -> VoidC
    def remove(self) -> X

let ContainerFactoryC = FunC[CONTAINER!]

def container_example(factory: ContainerFactoryC,
                      elements: Cons.list?) -> Cons.list?:
    let container = factory()
    while cons?(elements):
        container.add(elements.car)
        elements = elements.cdr
    let result = nil()
    while not container.empty?():
        result = cons(container.remove(), result)
    Cons.rev(result)

class ListStack (CONTAINER):
    let head: Cons.list?

    def __init__(self):
        self.head = nil()
    
    def empty?(self):
        nil?(self.head)
    
    def add(self, element):
        self.head = cons(element, self.head)
    
    def remove(self):
        let result = self.head.car
        self.head = self.head.cdr
        result

##
# let s = ListStack()
# s
# s.add(5)
# s.add(7)
# s.add(9)
# s.empty?() » False
# s.remove() » 9
# s.remove() » 7
# s.remove() » 5
# s.remove() » error
# s.add(5)
# s.add(7)
# s
# container_example(ListStack, cons(2, cons(3, cons(4, nil()))))

##

def generic_search(factory: ContainerFactoryC,
                   a_graph: DIGRAPH!, start: nat?) -> SearchTreeC:
   let result = [ False; a_graph.len() ]
   let to_do = factory()
   result[start] = True
   to_do.add(start)
   while not to_do.empty?():
       let node = to_do.remove()
       def each(succ):
           if not result[succ]:
               result[succ] = node
               to_do.add(succ)
       Cons.foreach(each, a_graph.succs(node))
   result


class LLQueue (CONTAINER):
    let head: Cons.list?
    let tail: Cons.list?
    
    def __init__(self):
        self.head = nil()
        self.tail = nil()
    
    def empty?(self):
        nil?(self.head)
    
    def add(self, element):
        let old_tail = self.tail
        self.tail = cons(element, nil())
        if nil?(self.head):
            self.head = self.tail
        else:
            old_tail.cdr = self.tail
    
    def remove(self):
        let result = self.head.car
        self.head = self.head.cdr
        if nil?(self.head):
            self.tail = self.head
        result
##
# let q = LLQueue()
# q
# q.add(3)
# q.add(4)
# q.add(5)
# ???
##