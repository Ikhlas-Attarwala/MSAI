;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |10-09-18 #3|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; a list-of-X is either:
; - '()
; - (cons X list-of-X)

;; filter?
;;signature>> remove-stuff : (X -> boolean?) list-of-X -> list-of-X
(define (remove-stuff p? l)
  (cond [(empty? l) empty]
        [else
         (cond
           [(p? (first l))
            (remove-stuff p? (rest l))]
           [else (cons
                  (first l)
                  (remove-stuff p? (rest l)))])]))



;signature>> remove-odds : list-of-numbers -> list-of-numbers
;purpose>> to remove the odd numbers from 'l'

;strategy>>
(define (remove-odds l)
  (remove-stuff odd? l))

;; remove-robby : list-of-string -> list-of-string
;; to remove robby's name from 'l'
(define (remove-robby l)
  (remove-stuff robby? l))

(define (robby? x)
  (string=? x "robby"))

;examples>>
(check-expect (remove-odds '()) '())
(check-expect (remove-odds (list 1)) '())
(check-expect (remove-odds (list 2)) (list 2))
(check-expect (remove-odds (list 1 2 3 4)) (list 2 4))

(check-expect (remove-robby '()) '())
(check-expect (remove-robby (cons "anything but robby" '()))
              (cons "anything but robby" '()))
(check-expect (remove-robby (cons "robby" '())) '())
(check-expect (remove-robby (list "1" "elephant" "robby" "robby" "stork"))
              (list "1" "elephant" "stork"))



