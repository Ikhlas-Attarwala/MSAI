;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |10-09-18 #4|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; a list-of-X is either:
; - '()
; - (cons X list-of-X)

;;signature>> map : (X -> Y) list-of-X -> list-of-Y
(define (my-map f l)
  (cond [(empty? l) '()]
        [else
         (cons (f (first l))
               (my-map f (rest l)))]))

;;signature>> negate-all : list-of-boolean -> list-of-boolean
;;purpose>> to negate all of the booleans in 'lob'
#;;template>>
(define (negate-all lob)
  (cond [(empty? lob) ...]
        [else
         (... (first lob)
              (negate-all (rest lob)))]))
;;body>>
(define (negate-all lob)
  (my-map not lob))

;;examples>>
(check-expect (negate-all '()) '())
(check-expect (negate-all (list #f)) (list #t))
(check-expect (negate-all (list #t #t)) (list #f #f))

;;signature>> get-widths : list-of-image -> list-of-number
;; to compute the widths of the images in 'loi'
#;;template>>
(define (get-widths loi)
  (my-map image-width loi))
;;body>>
(define (get-widths loi)
  (cond [(empty? loi) empty]
        [else (cons                  ; !!!CANNOT USE LIST B/C IT WOULD RETURN 2 ELEMENTS
               (image-width (first loi))
               (get-widths (rest loi)))]))

;; NEVER USE LIST IN THE MIDDLE OF A FUNCTION
;; ONLY USE IT IN THE TESTS YOU CHECK

(check-expect (get-widths '()) '())
(check-expect (get-widths (list (square 40 "solid" "black")))
              (list 40))


