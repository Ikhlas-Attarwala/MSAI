;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |10-23-18 #1|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define tmp 0)


#|

accumulators
------------

Let's consider a function r2a (relative to absolute) that converts a
series of numbers from their relative positions:

|-----|----|-------|---|---|
0     50   40      70  30  30


|-----|----|-------|---|---|
0     50   90      160 190 220


We can rpresent the positions (both relative and absolute as lists of numbers:
|#

; r2a/sofar : [Listof Number] Number -> [Listof Number]
; ACCUMULATOR INVARIANT : tally is the sum of the numbers seen so far
#; ; template
(define (r2a/sofar l tally)
  (cond [(empty? l) ...]
        [else
         ... (first l)
         ... (r2a/sofar (rest l) tally)]))

; body
(define (r2a/sofar l tally)
  (cond [(empty? l) '()]
        [else
         (cons (+ tally (first l))
               (r2a/sofar (rest l)
                          (+ tally (first l))))]))

; r2a : [Listof Number] -> [ListofNumber]
; purpose : see above
; strategy : structural decomposition

; (0 (sqr (length l))) running time
#; ; template
(define (r2a l)
  (cond [(empty? l) ...]
        [else
         ... (first l)
         ... (r2a (rest l))]))
#; ; body old
(define (r2a l)
  (cond [(empty? l) '()]
        [else
         ; l = '(1 3 6)
         ; (first l) = 1
         ; (rest l) = '(2 3)
         ; (r2a (rest l)) = '(2 5)
         ; we want: '(1 3 6)
         (cons (first l)
               (add-to-each (first l)
                            (r2a (rest l))))]))

; body
(define (r2a l)
  (r2a/sofar l 0))

; add-to-each : Number [Listof Number] -> [Listof Number]
; O(|l|)
(define (add-to-each x l)
  (map (λ (y) (+ x y))
       l))

(check-expect (add-to-each 3 '(4 6 7))
              '(7 9 10))

; example as test:
(check-expect (r2a '()) '())
(check-expect (r2a '(50 0)) '(50 50))
(check-expect (r2a '(1 2 3)) '(1 3 6))
(check-expect (r2a '(0 50 40 70 30 30)) '(0 50 90 160 190 220))