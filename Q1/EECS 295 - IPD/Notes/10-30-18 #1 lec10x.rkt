;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |10-30-18 #1 lec10x|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; This demonstrates DFS in ISL+λ using an accumulator for the seen set.

;; A Graph is:
;;  (make-graph Natural (Natural[< nodes] -> [Listof Natural(< nodes)]))
;; the `nodes` field tells us the number of nodes in the graph
;; nodes are always the natural numbers between 0 and the value of `nodes`
(define-struct graph (nodes neighbors))

(define a-graph
  (make-graph
   7
   (λ (node)
     (cond
       [(= node 0) (list 1)]
       [(= node 1) (list 3 4)]
       [(= node 2) (list 4 5)]
       [(<= 3 node 5) (list 6)]
       [(= node 6) '()]))))

(check-expect ((graph-neighbors a-graph) 2) (list 4 5))

(define a-cyclic-graph
  (make-graph
   3
   (λ (node)
     (cond
       [(= node 0) '(1)]
       [(= node 1) '(0)]
       [(= node 2) '()]))))

;; A REResult is (make-re-result Boolean [List-of Natural])
(define-struct re-result (found? seen))

;;; ACCUMULATOR is a parameter that keeps a record of what has happened so far in the recursion


;; route-exists?/a : Graph Natural Natural [List-of Natural] -> REResult
;;; also called depth-first-search
;; Is there a route, not passing through `seen-so-far`?
;;; Determines whether `graph` contains a path `src` to `dest` that does not pass through any of seen
;;; strategy : generative recursion? (anything with generative recursion has a termination function)

;;; O(V + E*logV) --??--> O(V + E)

(define (route-exists?/a graph src dest seen-so-far)
  (cond
    [(= src dest) (make-re-result #true seen-so-far)]
    [(already-seen? src seen-so-far) (make-re-result #false seen-so-far)]
    ;[(member src seen) (make-re-result #false seen)]
    [else (any-route-exists?/a graph
                               ((graph-neighbors graph) src)
                               dest
                               (cons src seen-so-far))]))

;; already-seen? : Natural [List-of Natural] -> Boolean
(define (already-seen? n lon)
  (ormap (λ (m) (= n m)) lon))

;; any-route-exists?/a : Graph [List-of Natural] Natural [List-of Natural]
;;                       -> REResult
;; Is there a route from any of `srcs`, not passing through `seen-so-far`.
;;; Determines whether `graph` contains a path `src` to `dest` that does not pass through any of seen
(define (any-route-exists?/a graph srcs dest seen-so-far)
  (cond
    [(empty? srcs) (make-re-result #false seen-so-far)]
    [else
     (local
       [(define result0 (route-exists?/a graph (first srcs) dest seen-so-far))]
       (cond
         [(re-result-found? result0) result0]
         [else
          (any-route-exists?/a graph (rest srcs) dest
                               (re-result-seen result0))]))]))

;; route-exists? : Graph Natural Natural -> Boolean
;; Is there a path from `in` to `out` in `graph`?
(define (route-exists? graph in out)
  (re-result-found? (route-exists?/a graph in out '())))

(check-expect (route-exists? a-graph 0 3) #true)
(check-expect (route-exists? a-graph 3 0) #false)
(check-expect (route-exists? a-cyclic-graph 0 1) #true)
(check-expect (route-exists? a-cyclic-graph 0 2) #false)
(check-expect (route-exists? a-cyclic-graph 2 0) #false)



(define (a-deep-graph n)
  (make-graph n
              (λ (node)
                (cond 
                  [(>= node (- n 3)) '()]
                  [(even? node) (list (+ 2 node) (+ 3 node))]
                  [else (list (+ 1 node) (+ 2 node))]))))

;; type in : (graph-neighbors (a-deep-graph 9) 5))
;; type in : (route-exists? (a-deep-graph 11) 0 10))
;; type in : (route-exists? (a-deep-graph 101) 0 100))


;;; need an accumulator that goes down AND comes back up
;;; each step we take, it gets passed along (never to shrink).
;;; implies that if we want it passed along, the function needs to return it


