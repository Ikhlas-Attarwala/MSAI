;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |10-09-18 #1|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; insertion-sort : list-of-number -> list-of-number
;; to compute an ordered permutation of 'l'

(define (insertion-sort l)
  (local [
          ;; sort : list-of-number -> list-of-number
          ;; to compute an ordered permutation of 'l'         
          (define (sort l)
            (cond [(empty? l) '()]
                  [else
                   (insert (first l)
                           (sort (rest l)))]))
          ;; insert : number list-of-number [sorted] -> list-of-number [sorted]
          (define (insert x ls)
            (cond [(empty? ls) (cons x '())]
                  [else
                   (cond [(< x (first ls)) (cons x ls)]
                         [else (cons (first ls) (insert x (rest ls)))])]))
          ]
    (sort l))) ;body of local (what it returns)

(check-expect (insertion-sort (list 9 8 7 6 5 4))
              (list 4 5 6 7 8 9))

;;; (LOCAL [<DEFN1> <DEFN2> ...] <EXPR>)
;;; learn: syntax (where parens and everything goes)
;;;        semantics (how do you hand evaluate it)
;;;        pragmatics (why do we have this)