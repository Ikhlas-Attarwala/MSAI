;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |10-11-18 #1|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;; FAMILY TREE

; a family-tree is
; - (make-person string number string list-of-family-tree)

(define-struct parent (name year eyes children))
;;; name the box, and then name the fields (diff. then when we write a data def.)
;;; in a data definition, we're going to say what the data is that goes inside the box

;;; NOT A DATA DEFINITION B/C OF THE X. HAVE TO DEFINE IT
; a (list-of X) is
; - '()
; - (cons X (list-of X))

; a list-of-family-tree is either:
; - '()
; - (cons family-tree list-of-family-tree)

; a number-or-boolean-or-list-of-string is either:
; - a number
; - a boolean
; - a list-of-string

; Gustav : family-tree
(define Gustav (make-parent "Gustav" 1988 "brown" empty))

; Fred : family-tree
(define Fred (make-parent "Fred" 1966 "pink" (list Gustav)))
;(list Gustav) is the same as (cons Gustav empty)

; Eva : family-tree
(define Eva (make-parent "Eva" 1965 "blue" (list Gustav)))

; Dave : family-tree
(define Dave (make-parent "Dave" 1955 "black" empty))

; Adam : family-tree
(define Adam (make-parent "Adam" 1950 "yellow" empty))

; Carl : family-tree
(define Carl (make-parent "Carl" 1926 "green" (cons Adam (cons Dave (cons Eva empty)))))

; Bettina : family-tree
(define Bettina (make-parent "Bettina" 1926 "green" (cons Adam (cons Dave (cons Eva empty)))))

; blue-eyed-person? : family-tree -> boolean
; to determine if there is a blue-eyed person in 'a-ft'
; strategy: structural decomposition
;;; q1 : alternatives? YES!! (does it have either: or not?)
;;; q2 : compound data? YES!! (do the individual types of pieces of the signature have multiple parts?)
;;; q3 : references? YES!! (are there any references to other data definitions?)
#; ;template
(define (blue-eyed-person? a-ft)
  (... (parent-eyes a-ft) ...
       (any-blue-eyed-people? (parent-children a-ft))))

; body
(define (blue-eyed-person? a-ft)
  (or (string=? "blue" (parent-eyes a-ft))
      (any-blue-eyed-people? (parent-children a-ft))))

; any-blue-eyed-people? : list-of-family-tree -> boolean
; determine if any people in 'a-loft' have blue eyes
; strategy: structural decomposition
;;; q1: altenatives? YES!! (2)
;;; q2: compound data? NO!!
;;; q3: references? YES!!
#; ;template
(define (any-blue-eyed-people? a-loft)
  (cond [(empty? a-loft) ...]
        [else (... (blue-eyed-person? (first a-loft)) ...
                   (any-blue-eyed-people? (rest a-loft)))]))

; body
(define (any-blue-eyed-people? a-loft)
  (cond [(empty? a-loft) #f]
        [else
         (or (blue-eyed-person? (first a-loft))
             (any-blue-eyed-people? (rest a-loft)))]))

(check-expect (blue-eyed-person? Dave) #f)
(check-expect (blue-eyed-person? Eva) #t)
(check-expect (blue-eyed-person? Carl) #t)
(check-expect (blue-eyed-person? Fred) #f)

(check-expect (any-blue-eyed-people? empty) #f)
(check-expect (any-blue-eyed-people? (cons Dave '())) #f)
(check-expect (any-blue-eyed-people? (cons Eva '())) #t)
(check-expect (any-blue-eyed-people? (cons Bettina '())) #t)