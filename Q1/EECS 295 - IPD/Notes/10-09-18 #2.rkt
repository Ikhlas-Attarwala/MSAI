;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |10-09-18 #2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; sixteenth : number -> number
;; to compute x^16

#;
(define (sixteenth x)
(* x x x x
x x x x
x x x x
x x x x))

(define (sixteenth x)
  (local[
         (define squared (* x x))
         (define fourth-power (* squared squared))
         (define q (* fourth-power fourth-power))
         ]
    (* q q)))

(check-expect (sixteenth 1) 1)
(check-expect (sixteenth -1) 1)
(check-expect (sixteenth 0) 0)
(check-expect (sixteenth 2) 65536)
(check-expect (sixteenth 4) 4294967296)

;; ============================== old

;; a list-of-numbers is one of:
;; - empty or '()
;; - (cons number list-of-numbers)

;; biggest : non-empty-list-of-numbers -> number
;;strategy -> structural decomoposition -> template -> body
#;
(define (biggest lon)
  (cond [(empty? (rest lon)) (first lon)]
        [else
         (cond[(> (first lon) (biggest (rest lon)))
               (first lon)]
              [else
               (biggest (rest lon))])]))

;; ============================== new
;; f : number number -> boolean
(define (f x y)
  ...)

;; a non-empty-list-of-X is one of:
;; - (cons X '())
;; - (cons X non-empty-list-of-X)

;; est : (X X -> boolean) non-empty-list-of-X -> X
;; to find the 'cmp'iest element of 'lon'
(define (est cmp lon)
  (cond
    [(empty? (rest lon)) (first lon)]
    [else
     (local [(define biggest-of-the-rest
               (est cmp (rest lon)))]
       (cond
         [(cmp (first lon) biggest-of-the-rest)
          (first lon)]
         [else biggest-of-the-rest]))]))


;; compare : non-empty-list-of-numbers -> number
;;strategy -> structural decomoposition -> template -> body
;; find the biggest number in 'lon'
(define (biggest lon) (est > lon))

;; smallest : non-empty-list-of-numbers -> number
;;strategy -> structural decomoposition -> template -> body
;; find the smallest number in 'lon'
(define (smallest lon) (est < lon))

;; examples
(check-expect (biggest (cons 1 '())) 1)
(check-expect (biggest (list 2 3 1)) 3)

;; examples
(check-expect (smallest (cons 1 '())) 1)
(check-expect (smallest (list 2 3 1)) 1)



(est string<=? (list "ABC" "DEF" "abc" "def"))
