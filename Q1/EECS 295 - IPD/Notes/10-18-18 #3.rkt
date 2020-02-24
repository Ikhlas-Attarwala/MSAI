;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |10-18-18 #3|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; generative recursion vs structural recursion

; make-secret : natural -> (nat -> string)
(define (make-secret n)
  (local [(define secret (random n))
          (define (guesser m)
            (cond
              [(> secret m) "too small!"]
              [(= secret m) "right!"]
              [(< secret m) "too large!"]))]
    guesser))

(define a-secret (make-secret 5000))

; find-secret : (nat -> string) -> nat
; to find the secret
(define (find-secret a-secret)
  (find-secret-between a-secret 0 10239102931))

; find-secret-greater-than : (nat -> stringi) nat -> nat
; to find the secret, on the assumption it is larger than `n`
(define (find-secret-between a-secret below above)
  (local [(define candidate (floor (/ (+ below above) 2)))]
    (cond
      [(string=? (a-secret candidate) "right!") candidate]
      [(string=? (a-secret candidate) "too large!")
       (find-secret-between a-secret candidate above)]
      [(string=? (a-secret candidate) "too small!")
       (find-secret-between a-secret below candidate)])))



(define (likes-11 n)
  (cond [(= n 11) "right!"]
        [else "wrong!"]))

(check-expect (find-secret (make-secret 1)) 0)
(check-expect (find-secret likes-11) 11)

;type in (find-secret a-secret) in shell

