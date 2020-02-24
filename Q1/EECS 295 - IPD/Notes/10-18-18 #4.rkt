;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |10-18-18 #4|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


;; quicksort : [Listof Number] -> [Listof Number]

(define (qsort l)
  (cond
    [(empty? l) '()]
    [else
     (local [(define pivot (first l))]
       (append (qsort (less-than pivot (rest l)))
               (list pivot)
               (qsort (greater-than pivot (rest l)))))]))

; greater-than : number [listof number] -> [listof number]
; to return all the numbers in `l` than are greater than `pivot`
#;; template
(define (greater-than pivot l)
  (filter (λ (x) ...)
          l))
; body
(define (greater-than pivot l)
  (filter (λ (x) (>= x pivot))
          l))


; less-than : number [listof number] -> [listof number]
; to return all the numbers in `l` than are less than `pivot`
(define (less-than pivot l)
  (filter (λ (x) (< x pivot))
          l))

(check-expect (qsort '()) '())
(check-expect (qsort (list 1 3 2)) (list 1 2 3))
(check-expect (qsort (list 1 3 2 1)) (list 1 1 2 3))

