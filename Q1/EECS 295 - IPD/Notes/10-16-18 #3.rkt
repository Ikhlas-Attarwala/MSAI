;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |10-16-18 #3|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


;;; OTHER ADTs

; - sequence
; - map or dictionary: {"a": 3, "b": 4}
;     - find : Key Map -> Value
;     - contains? : Key Map -> Boolean
;     - size : Map -> Natural
;     - insert : Key Value Map -> Map
;     - remove : Key Map -> Map
; - prioirity queue (collection of elements where each element has a priority)
;     - get-max : PQ -> Element
;     - remove-max : PQ -> PQ
;     - insert : PQ Element -> PQ
; graph

; set

;;; ==========================
;;; ==========================
;;; BANKER'S QUEUE


; A BankersQueue is (make-bq [List-of Number] [List-of Number])
; interp. queue contents is (append front (reverse back)) with the old end in front
(define-struct bq [front back])
; INVARIANT: if (empty? front) then (empty? back)

(define BQ-EX0 (make-bq (list 2 3 4) (list 7 6 5)))

; build-bq : [List-of Number] [List-of Number] -> BQ
; builds a BQ while maintaining the invariant
; strategy : DECISION TREE
; body
(define (build-bq front back)
  (cond
    [(empty? front) (make-bq (reverse back) '())]
    [else           (make-bq front back)]))

(check-expect (build-bq (list 2 3) (list 4 5))
              (make-bq (list 2 3) (list 4 5)))
(check-expect (build-bq '() (list 4 5))
              (make-bq (list 5 4) '()))

; empty-bq : BQ
(define empty-bq (make-bq '() '()))

#; ;template for all of them!
(define (empty-queue? #|(example)|# q)
  ... (bq-front q) ...
  ... (bq-back q) ...)

(define (empty-queue? q)
  (empty? (bq-front q)))

(define (enqueue q x)
  (build-bq (bq-front q)
            (cons x (bq-back q))))

(define (get-head q)
  (first (bq-front q)))

(define (dequeue q)
  (build-bq (rest (bq-front q))
            (bq-back q)))


;;; TIME COMPLEXITY:
; build-bq :
; - if front is empty, O(n)
; - if front is non-empty, O(1)

; enqueue:
; - if front is empty, O(1)
; - if front is non-empty, O(1)

; get-head:
; - if front is empty, O(1)
; - if front is non-empty, O(1)

; dequeue: O(n)

; What if we have n operations? Naively, it's quadratic: O(n^2)

; - enqueue k times = O(k)
; - dequeue once O(k)
; - dequeue again once O(1)
; - dequeue k-2 more times O(k)
;------------------------------
; sum total : O(k)
; called amortized complexity