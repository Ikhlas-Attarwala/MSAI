;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |10-23-18 #3 lec08c|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;graphs (representing neighbors using functions)
;; -----------------------------------------------

;; a Graph is:
;;  (make-graph Natural (Natural[< nodes] -> [Listof Natural(< nodes)]))
;; the `nodes` field tells us the number of nodes in the graph
;; nodes are always the natural numbers between 0 and the value of `nodes`

(define-struct graph (nodes neighbor))

#|
Here is a graph:

      0
     /
    /  
   1     2
   |\   /|
   | \ / |
   3  4  5
    \ | /
     \|/
      6

Imagine all arrows go down, so 0 is connected 1,
1 is connected to 3, etc.

How can we represent this graph as a graph struct?
|#

(define a-graph
  (make-graph
   7
   (λ (name-of-node)
     (cond
       [(= name-of-node 0) (list 1)]
       [(= name-of-node 1) (list 3 4)]
       [(= name-of-node 2) (list 4 5)]
       [(<= 3 name-of-node 5) (list 6)]
       [(= name-of-node 6) '()]))))

(define cyclic-graph
  (make-graph
   2
   (λ (name-of-node)
     (cond [(= name-of-node 0) (list 1)]
           [(= name-of-node 1) (list 0)]))))

(define another-cyclic-graph
  (make-graph
   2
   (λ (name-of-node)
     (cond [(= name-of-node 0) (list 0)]
           [(= name-of-node 1) '()]))))

#|


  1   2
  | X |
  3   4
  | X |
  5   6
  | X |
  7   8
  | X |
  9   10


|#

(define (make-a-very-slow-graph size)
  (make-graph size
              (λ (n) (cond [(zero? n) '()]
                           [(= (- size 1) n) '()]
                           [(= (- size 2) n) '()]
                           [(odd? n) (list (+ n 2) (+ n 3))]
                           [(even? n) (list (+ n 1) (+ n 2))]))))


(

;; add-edge : Graph Natural Natural -> Graph
;; (define (add-edge g n1 n2) ...)

; ... how do we test this function? We have to write
; a graph=? function and then use check-expect with it.

;; graph=? : Graph Graph -> Boolean
;; to determine if two Graphs represent the same graph
(define (graph=? g1 g2)
  (and (= (graph-nodes g1)
          (graph-nodes g2))
       (same-neighbors? (graph-neighbor g1)
                        (graph-neighbor g2)
                        (graph-nodes g1))))

;; same-neighbors? : [Natural -> [listof Natural]]
;;                   [Natural -> [listof Natural]]
;;                   Natural
;;                -> Boolean
;; to determine if the edge functions are the same
(define (same-neighbors? e1 e2 n)
  (cond
    [(zero? n) #true]
    [else (and (same-elements? (e1 (- n 1))
                               (e2 (- n 1)))
               (same-neighbors? e1 e2 (- n 1)))]))

(check-expect (graph=? a-graph a-graph) #true)
(check-expect (graph=? (make-graph 1 (λ (x) (list x)))
                       (make-graph 1 (λ (x) (list 0))))
              #true)
(check-expect (graph=? (make-graph 2 (λ (x) (list 0 1)))
                       (make-graph 2 (λ (x) (list 1 0))))
              #true)
(check-expect (graph=? (make-graph 2 (λ (x) (list 0 1)))
                       (make-graph 2 (λ (x) (list 1 0))))
              #true)
(check-expect (graph=? (make-graph 2 (λ (x) (list 0)))
                       (make-graph 2 (λ (x) (list 1 0))))
              #false)

;; same-elements? : [Listof X] [Listof X] -> Boolean
;; to determine if the two lists have the same elements
;; Strategy: function compositions
(define (same-elements? l1 l2)
  (and (all-inside? l1 l2)
       (all-inside? l2 l1)))

(check-expect (same-elements? '() '()) #true)
(check-expect (same-elements? (list 1) '()) #false)
(check-expect (same-elements? '() (list 1)) #false)
(check-expect (same-elements? (list 1) (list 1)) #true)
(check-expect (same-elements? (list 1) (list 0)) #false)
(check-expect (same-elements? (list 1 0) (list 0 1)) #true)

;; all-inside? : [Listof X] [Listof X] -> Boolean
;; to determine if all of the elements of l1 are in l2 (a.k.a. subset?)
;; Strategy: structural decomposition
(define (all-inside? l1 l2)
  (cond
    [(empty? l1) #true]
    [else (and (member? (first l1) l2)
               (all-inside? (rest l1) l2))]))
  
(check-expect (all-inside? '() '()) #true)
(check-expect (all-inside? (list 1) '()) #false)
(check-expect (all-inside? '() (list 1)) #true)
(check-expect (all-inside? (list 1) (list 1)) #true)
(check-expect (all-inside? (list 1) (list 0)) #false)
(check-expect (all-inside? (list 1 0) (list 0 1)) #true)


; |#
;; ---------------------------------------------------------

;; route-exists? : graph nat nat -> boolean

#|
For this function, structural recursion won't work. I don't
see any helper functions. Lets try generative recursion. 

Okay. Generative recursion is much more fuzzy. But, we can
still look for two things: a few simple cases that we know
what to do, and then maybe a way to trim down complex cases
into a simpler cases that we can recur with.

Any ideas here for some simple cases?

complex ones that can be made slightly simpler?
|#

(define (route-exists? g start dest)
  (route-exists? g start dest '()))

;; route-exists? : Graph Natural Natural -> Boolean
;; determine if a route exists in the graph between start and dest
;; IF YOU USE RECURSION AND DIDN'T FOLLOW THE TEMPLATE, YOU'RE USING GENERATIVE RECURSION
;; strategy : generative recursion
;; ACCUMULATOR INVARIANT: seen-so-far is the nodes that we have already considered
(check-expect (route-exists?/accum a-graph 0 3 '()) #t)
(check-expect (route-exists?/accum a-graph 0 2 '()) #f)

(define (route-exists?/accum graph start dest seen-so-far)
  (cond
    [(= start dest) #true]
    [(member? start seen-so-far) #false]
    [else
     (any-route-exists? graph
                        ((graph-neighbor graph) start)   ;PYTHON : g.neighbor(start)
                        dest
                        (cons start seen-so-far))]))     ; new accumulator



;; any-route-exists? : Graph [Listof Natural] Natural [Listof Natural] -> Route-info (will update)
;; to determine if a route exists between any of the lemenets of `start` and `dest`
;; strategy : structural decomposition on `start`
(define (any-route-exists? graph start dest)
  (cond
    [(empty? start) #false]
    [else (or (route-exists? graph (first start) dest)
              (any-route-exists? graph (rest start) dest))]))

#|
Okay, that works for the graph above.

But, what happens if the graph has a cycle?

Termination. Again!

Lets look more carefully at this problem in a simpler graph.
|#

;; (these examples will not terminate if run
;;  so they are commented out):
#|
(define another-graph 
  (make-graph 2
	      (lambda (x)
		(cond
		 [(= x 0) (list 1)]
		 [(= x 1) (list 0)]
		 [(= x 2) '()]))))

  (route-exists? a-graph 0 2)
= (any-route-exists? a-graph (list 1) 2)
= (or (route-exists? a-graph 1 2)
      (any-route-exists? a-graph '() 2))
= (or (any-route-exists? a-graph (list 0) 2)
      (any-route-exists? a-graph '() 2))
= (or (or (route-exists? a-graph 0 2)
          (any-route-exists? a-graph '() 2))
      (any-route-exists? a-graph '() 2))
|#

;; uhoh.... we've seen that one before....
;; How would you and I do this?
;; Well, we could keep track of where we've been.

;; Sound like context information to you?
;; Accumulator!

;; What kind of value?

;; list of nats:

;; maintain it:

#|
(define (route-exists?/a graph src dest seen-so-far)
  (cond
   [(= src dest) #true]
   [else (any-route-exists?/a graph
			    ((graph-neighbors graph) src)
			    dest
			    (cons src seen-so-far))]))

(define (any-route-exists?/a graph srcs dest seen-so-far)
  (cond
    [(empty? srcs) #false]
    [else (or (route-exists? graph (first srcs) dest seen-so-far)
              (any-route-exists? graph (rest srcs) dest seen-so-far))]))

(define (route-exists? in out graph)
   (route-exists?/a in out graph '()))
|#

;; take advantage of it:

#|
(define (route-exists?/a graph src dest seen-so-far)
  (cond
   [(= src dest) #true]
   [(already-seen? src seen-so-far) #false]
   [else (any-route-exists? graph
			    ((graph-neighbors graph) src)
			    dest
			    (cons src seen-so-far))]))

(define (already-seen? src seen-so-far)
  (cond
   [(empty? seen-so-far) #false]
   [else (or (= src (first seen-so-far))
	     (already-seen? g node (rest seen-so-far)))]))
|#


;; What is the running time of this function?

;; Well, differently shaped graphs are going to give us different
;; pictures of the running times for this function. Lets consider graphs
;; that are straight lines where we ask if the first node is connected
;; to the last node:

#|
   A
   |
   B
   |
   C
   |
  ...
   |
   Z

Clearly that is going to take O(n) time.

What happens for a graph that looks like this, tho:

  start     end
   /\
  A  B
  |\/|
  |/\|
  C  D
  |\/|
  |/\|
  E  F
  |\/|
  |/\|
  G  H

  ....

  W  X
  |\/|
  |/\|
  Y  Z


where we ask if 'start' is connected to 'end', but 'end' isn't
connected to anything at all. So the answer will also be #false, but
how long does it take to figure that out?

Exponential time.

We need a new technique to fix this one.
|#
