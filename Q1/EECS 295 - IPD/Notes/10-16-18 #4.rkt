;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |10-16-18 #4|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


;;; BINARY SEARCH TREE

; Time to do a BST is proportional to height
; worst case = O(n)
; best case = O(logn)
; root = middle. if you know all the numbers, insert the root first,
;                and then its children and on and on (only if you know the shape you want)


; rotate-right : RandNumTree -> RandNumTree
; performs a right rotation

; ASSUMPTION: d is non-empty and (node-left d) is non-empty

; FOLLOWING .RKT FROM LEC06C.RKT
(define (rotate-right d)
  (new-node (node-key (node-left d))
            (node-left (node-left d))
            (new-node (node-key d)
                      (node-right (node-left d))
                      (node-right d))))

(check-expect (rotate-right
               (new-node 4
                         (new-node 2 '() '())
                         (new-node 6 '() '())))
              (new-node 2
                        '()
                        (new-node 4
                                  '()
                                  (new-node 6
                                            '()
                                            '()))))

; rotate-left : RandNumTree -> RandNumTree
; performs a left rotation

; ASSUMPTION: d is non-empty and (node-right d) is non-empty
(define (rotate-left d)
  (new-node (node-key (node-right d))
            (node-right (node-right d))
            (new-node (node-key d)
                      (node-left (node-right d))
                      (node-left d))))

; root-insert : RandNumTree Number -> RandNumTree
; inserts an element at the root
; strategy : structural decomposition
#; ;template
(define (root-insert t k)
  (cond [(empty? t) ...]
        [else
         ... (node-key t)
         ... (root-insert (node-left t))
         ... (root-insert (node-right t))]))
#; ;body
(define (root-insert t k)
  (cond [(empty? t) (new-node k '() '())]
        [else
         (cond [(< k (node-key t)) ...]
               [(> k (node-key t)) ...]
               [else ...])]))

;body #2
(define (root-insert t k)
  (cond [(empty? t) (new-node k '() '())]
        [else
         (cond
           [(< k (node-key t))
            (rotate-right (new-node
                           (node-key k)
                           (root-insert (node-left t) k)
                           (node-right k)))]
           [(> k (node-key t))
            (rotate-left (new-node
                          (node-key k)
                          (node-left k)
                          (root-insert (node-right t) k)))]
           [else t])]))

(check-expect (root-insert (new-node 4
                                     (new-node 2 '() '())
                                     (new-node 6 '() '()))
                           5)
              (new-node 5
                        (new-node 4
                                  (new-node 2 '() '())
                                  '())
                        (new-node 6 '() '())))
(check-expect (root-insert A-TREE 4) A-TREE)