;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |10-23-18 #2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define tmp 0)

#|

a Natural (Whole) is either:
 - 0
 - (add1 Natural)

|#

; nat_t : Natural -> ???
#;
(define (nat_t n)
  (cond
    [(zero? n) ...]
    [else
     (nat_t (sub1 n))]))

; for (int x = 0; x<n; x++)

; build-strings : Natural String -> [Listof String]
; to build a list of `n` strings, all of which are `s`
(define (build-strings n s)
  (cond
    [(zero? n) '()]
    [else
     (cons s
           (build-strings (sub1 n) s))]))

(check-expect (build-strings 0 "") '())
(check-expect (build-strings 0 "any string at all") '())
(check-expect (build-strings 3 "a") '("a" "a" "a"))