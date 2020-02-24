;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |10-18-18 #2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


; A Binomial-Heap is a [Binomial-Heap-Ranked 0]

; A [Binomial-Heap-Ranked n] is either:
; - (cons [Or #false [Binomial-Tree-Ranked n]]
;         [Binomial-Heap-Ranked (add1 n)])
; - '()
; INVARIANT: the last element of the list is not #false

; ================ also written as:
; A [Binomial-Heap-Ranked n] is either:
; - (cons #false                   Binomial-Heap-Ranked (add1 n))
; - (cons (Binomial-Tree-Ranked n) Binomial-Heap-Ranked (add1 n))
; - '()
; INVARIANT: the last element of the list is not #false
; ================

; A [Binomial-Tree-Ranked n] is either:
; - (make-node Number [Binomial-Tree-List n])
; INVARIANT: the `Number` is smaller than any of
;             the numbers in `[Binomial-Tree-List n]`
; (this is the heap invariant)

; ^^ I think it should be `Number` is less than any of the numbers in `[Binomial-Tree-List n]`

; A [Binomial-Tree-List 0] is '()
; A [Binomial-Tree-List n], where n>0 is
;   (cons [Binomial-Tree-Ranked (sub1 n)]
;         [Binomial-Tree-List (sub1 n)])

(define-struct node (value children))

#;
(cons #f '()) ;; -- not a heap, ends with #f
(define one-number-heap              ;ranked 0
  (cons (make-node 4 empty)
        empty))

;two #
(define two-number-heap
  (cons #false
        (cons (make-node 4
                         (list (make-node 5 '())))
              '())))

;three #
(define three-number-heap
  (cons (make-node 11'())
        (cons (make-node 4
                         (list (make-node 5 '())))
              '())))
;another three # that works
(define three-number-heap-b
  (cons (make-node 4'())
        (cons (make-node 11
                         (list (make-node 5 '())))
              '())))

#; ;NOT A BINOMIAL HEAP:
(cons (make-node 4 '())              ;needs to be a binomial heap ranked 0 (it is)
      (cons (make-node 5'())         ;needs to be a binomial heap ranked 1 (it isn't)
            '()))



; empty-heap : Binomial-Heap
(define empty-heap '())

; empty-heap? : Binomial-Heap -> Boolean
(define (empty-heap? h)
  (empty? h))

; find-min : Binomial-Heap -> [OR Number #false]
; to find the smallest number in the heap, if any
(define find-min
  ...)


(check-expect (find-min '()) #f)
(check-expect (find-min one-number-heap) 4)
(check-expect (find-min two-number-heap) 4)
(check-expect (find-min three-number-heap) 4)
(check-expect (find-min three-number-heap-b) 4)

