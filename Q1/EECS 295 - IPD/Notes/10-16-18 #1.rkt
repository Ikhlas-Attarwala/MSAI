;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |10-16-18 #1|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


;;; Abstraction : leaves stuff out and doesn't include all the details

; Queue ADT
; ---------

;« 1 2 3 «

; ========
; ======== SIGNATURE:
; empty-queue? : queue -> boolean
; enqueue : element queue -> queue
; get-front : queue -> element
; dequeue -> queue -> queue

; ========
; ======== LAWS:
; (empty-queue? ««)) => #true
; (empty-queue? «a b ...«) => #false

; (enqueue b «a0 ...«) => «a0 ... b«

; (get-front ««) => ERROR
; (get-front «a0 a1 ...«) => a0

; (dequeue ««) => ERROR
; (dequeue «a0 a1 ...«) => «a1 ...«

; ========
; a [List-of-X] is one of:
; - '()
; - (cons x [List-of-X])

; a [Queue-of-X] is [List-of-X]

; «a0 a1 a2« is represented as (cons a2 (cons a1 (cons a0 empty)))
; «a0 a1 a2« is represented as (cons a0 (cons a1 (cons a2 empty)))

; A Queue0 is a [List-of Number]
; interp. the front of the list is the old end of the queue

#|
; queue-empty? : QueueO -> Boolean
; determines whether the given queue is empty
; examples
(check-expect (queue-o-empty? '()) #t)
(check-expect (queue-o-empty? (list 2 3 4)) #f)
; template
#;(define (queue-o-empty? q)
    ...)
;body
(define (queue-o-empty? q)
  (empty? q))

; enqueue-o : QueueO Number -> QueueO
; enqueues an element on the given queue
#; ;template
(define (enqueue-o q n)
  (cond [(empty? q) ...]
        [else ... (first q) ...
              ... (rest q) ...]))
;body
#;(define (enqueue-o q n)
    (cond [(empty? q) (list n)]
          [else
           (cons (first q)
                 (enqueue-o (rest q) n))]))
;or just
(define (enqueue-o q n)
  (append q (list n)))

(check-expect (enqueue-o 5 '()) (list 5))
(check-expect (enqueue-o 5 (list 2 3 4)) (list 2 3 4 5))

; get-head-o : QueueO -> Number
; returns the oldest element of the queue
(define (get-head-o q)
  (first q))

(check-expect (get-head-o (list 2 3 4)) 2)
(check-expect (get-head-o '()) #f) ;??

; dequeue-o : QueueO -> QueueO
; removes the oldest element from the queue
(define (dequeue-o q)
  (rest q))

(check-expect (dequeue-o (list 2 3 4)) (list 3 4))






; enqueue-n : QueueN Number -> QueueN
; enqueues an element on the given queue

(define (enqueue-n q n)
  (cons n q))

#; ;template
(check-expect (enqueue-n 5 '()) (list 5))
(check-expect (enqueue-n 5 (list 2 3 4)) (list 5 2 3 4))

;get-head-n : QueueN -> Number
(define (get-head-n q)
  (first (reverse q)))

; dequeue-n : QueueN -> QueueN
; removes the oldest element from the queue
(define (dequeue-n q)
  (reverse (rest (reverse q))))

(check-expect (dequeue-n (list 2 3 4)) (list 2 3))
|#



(define (queue-o-empty? q)            ;Time complexity: O(1)
  (empty? q))
(define (enqueue-o q n)               ;Time complexity: O(n)
  (append q (list n)))
(define (get-head-o q)                ;Time complexity: O(1)
  (first q))
(define (dequeue-o q)                 ;Time complexity: O(1)
  (rest q))

;second does more allocations than the above

(define (queue-n-empty? q)            ;Time complexity: O(1)
  (empty? q))
(define (enqueue-n q n)               ;Time complexity: O(1)
  (cons n q))
(define (get-head-n q)                ;Time complexity: O(n)
  (first (reverse q)))
(define (dequeue-n q)                 ;Time complexity: O(n)
  (reverse (rest (reverse q))))


