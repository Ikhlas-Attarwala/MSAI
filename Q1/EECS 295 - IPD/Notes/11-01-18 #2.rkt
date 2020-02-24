#lang dssl2
import cons

struct WEdge:
    let src: nat?
    let weight: num?
    let dst: nat?

interface WGRAPH:              #interface = way of describing a possible class that doesn't exist yet
    def len(self) -> nat?
    def succs(self, src: nat?) -> Cons.ListC[WEdge?]

class AdjMatWGraph (WGRAPH):
    let rows: VecC
    
    def __init__(self,len: nat?):
        self.rows = [ False; len]
        for i in len:
            self.rows = [[inf; len]; len]
    
    def len(self):
        self.rows.len()
    
    def succs(self, src):
        let result = nil()
        let row = self.rows[src]
        for dst, w in row:
            if w < inf:
                result = cons(WEdge(src, w, dst), result)
        result
    
    def set_edge (self, src: nat?, w: num?, dst: nat?) -> VoidC:
        self.rows[src][dst] = w

def build_wdigraph(len: nat?, edges: VecC[WEdge?]) -> AdjMatWGraph?:
    let result = AdjMatWGraph(len)
    for edge in edges:
        result.set_edge(edge.src, edge.weight, edge.dst)
    result

def build_wgraph(len: nat?, edges: VecC[WEdge?]) -> AdjMatWGraph?:
    let result = AdjMatWGraph(len)
    for edge in edges:
        result.set_edge(edge.src, edge.weight, edge.dst)
        result.set_edge(edge.dst, edge.weight, edge.src)
    result

#wikipedia : Dijkstra's Algorithm

let A_GRAPH = build_wgraph(7, [
    WEdge(1,  7, 2),
    WEdge(1,  9, 3),
    WEdge(1, 14, 6),
    WEdge(2, 10, 3),
    WEdge(2, 15, 4),
    WEdge(3, 11, 4),
    WEdge(3,  2, 6),
    WEdge(4,  6, 5),
    WEdge(5,  9, 6),
])

##
# A_GRAPH
# A_GRAPH ....???
##

# SSSP: Single Source, Shortest Paths
    
struct sssp:
    let preds: VecC[OrC(nat?, bool?)]
    let weights: VecC[num?]

def new_sssp(len: nat?, start_node: nat?) -> sssp?:
    let result = sssp([ False; len ], [ inf; len ])
    result.preds[start_node] = True
    result.weights[start_node] = 0
    result

def relax (state: sssp?, u: nat?, weight: num?, v: nat?) -> VoidC:
    let old_weight = state.weights[v]
    let new_weight = state.weights[u] + weight
    if new_weight < old_weight:
        state.weights[v] = new_weight
        state.preds[v] = u

# O(V^3) for an adjacency matrix
# does not work when you have negative cycles
# for adjacency lists, it would be O(V*E)
def bellman_ford(graph: WGRAPH!, start: nat?) -> sssp?:
    let result = new_sssp(graph.len(), start)
    for i_ in graph.len():
        for u in graph.len():
            Cons.foreach(λ edge: relax(result, u, edge.weight, edge.dst), graph.succs(u))
    result

# only works on non-negative weights
def dijkstra(graph: WGRAPH!, start_node: nat?) -> sssp?:
    let result = new_sssp(graph.len(), start)
    let visited = [ False; graph.len() ]
    
    # O(V)
    def find_nearest_unvisited():
        let best_so_far = False
        for v in graph.len():
            if not visited[v]:
                if (not best_so_far or
                        result.weights[v] < result.weights[best_so_far]):
                    best_so_far = v
        best_so_far
    
    # O(V)
    let u = find_nearest_unvisited()
    while u:
        Cons.foreach(λ edge: relax(result, u, edge.weight, edge.dst), graph.succs(u))
        visited[u] = True
        u = find_neareest_unvisited()
        
    result