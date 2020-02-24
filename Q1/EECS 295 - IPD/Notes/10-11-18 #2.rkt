;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |10-11-18 #2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;; COMPLEXITY

; lookup : db name -> ssn

; add    : db name ssn -> db

; mt     : db

; (define db1 (add ...))
; (define db2 (add ...))
;       .
;       .
;       .
;       .
; (define db100 (add ... db99))
;       .
;       .
;       n

; a db is either
; - '()
; - (cons (make-person name ssn) db)
(define-struct person (name ssn))

; say you had a tree that went down 100 people. If it branched off in both directions,
; it would have 2^(n-1) # of people

; ===============================
; ===============================

; a ssn is
; - a number

; a name is
; - a string

; a db is
; - "leaf"
; - (make-node name ssn db db)
;    INVARIANT: 'name' comes after every name in left
;               'name' comes before every name in right
(define-struct node (name ssn left right))

; an ssn-or-false is either:
; - ssn
; - #f

; DID NOT FINISH DATA DEFINITION COMMENTS
; add : db name ssn -> db
#; ;template
(define (add a-db name ssn)
  (cond [(string? a-db) ...]
        [else (... (node-name a-db)
                   (node-ssn a-db)
                   (add (node-left a-db) name ssn)
                   (add (node-right a-db) name ssn))]))

;body
(define (add a-db name ssn)
  (cond [(string? a-db) (make-node name ssn "leaf" "leaf")]
        [else (... (node-name a-db)
                   (node-ssn a-db)
                   (add (node-left a-db) name ssn)
                   (add (node-right a-db) name ssn))]))

; lookup : db name -> ssn or #f
; to find `name`'s ssn in `a-db`
; strategy: structural decomposition
; q1: yes
; q2: yes
; q3: yno
#; ;template (changed slightly)
(define (lookup a-db name)
  (cond [(string=? "leaf" a-db) ...]
        [else
         (cond [(string<? (node-name a-db) name)
                (make-node name
                           ssn
                           (add (node-left a-db) name ssn)
                           (node-right a-db))]
               [(string=? (node-name a-db) name)
                (make-node name
                           ssn
                           (node-left a-db)
                           (node-right a-db))]
               [else
                (make-node name
                           ssn
                           (node-left a-db)
                           (add (node-right a-db) name ssn))])]))

#; ;old body
(define (lookup a-db name)
  (cond [(string? a-db) #f]
        [else
         (cond
           [(string=? (node-name a-db) name)
            (node-ssn a-db)]
           [else
            (pick (lookup (node-left a-db) name)
                  (lookup (node-right a-db) name))])]))

#; ;new template
(define (lookup a-db name)
  (cond [(string? a-db) #f]
        [else
         (cond
           [(string<? (node-name a-db) name)
            ...]
           [(string=? (node-name a-db) name)
            ...]
           [else ...])]))

; new body
(define (lookup a-db name)
  (cond [(string? a-db) #f]
        [else
         (cond
           [(string<? (node-name a-db) name)
            (lookup (node-right a-db) name)]
           [(string=? (node-name a-db) name)
            (node-ssn a-db)]
           [else
            (lookup (node-left a-db) name)])]))

; pick : ssn-or-false ssn-or-false -> ssn-or-false
; to pick ssn if there is one, or return #f if there aren't any
; strategy: structural decomposition (on both)
; q1: yes
; q2:
; q3:
#; ;template
(define (pick sf1 sf2)
  (cond [(and (number? sf1) (number? sf2)) ...]
        [(number? sf1) ...] ; same as : (and (number? sf1) (not (number? sf2))) ... ]
        [(number? sf2) ...] ; same as : (and (not (number? sf1)) (number? sf2)) ... ]
        [else ...]))

; body
(define (pick sf1 sf2)
  (cond [(and (number? sf1) (number? sf2)) sf1]
        [(number? sf1) sf1] ; same as : (and (number? sf1) (not (number? sf2))) ... ]
        [(number? sf2) sf2] ; same as : (and (not (number? sf1)) (number? sf2)) ... ]
        [else #f]))



(check-expect (lookup "leaf" "tim") #f)
; ===============
(check-expect (lookup (make-node "tim" 0 "leaf" "leaf") "tim") 0)
(check-expect (lookup (make-node "kirk"
                                 0
                                 (make-node "bones" 1 "leaf" "leaf")
                                 (make-node "spock" 2 "leaf" "leaf"))
                      "bones")
              1)
(check-expect (lookup (make-node "kirk"
                                 0
                                 (make-node "bones" 1 "leaf" "leaf")
                                 (make-node "spock" 2 "leaf" "leaf"))
                      "spock")
              2)
(check-expect (lookup (make-node "kirk"
                                 0
                                 (make-node "bones" 1 "leaf" "leaf")
                                 (make-node "spock" 2 "leaf" "leaf"))
                      "kirk")
              0)
; ===============
(check-expect (pick #f #f) #f)
(check-expect (pick 1234 #f) 1234)
(check-expect (pick #f 1234) 1234)
(check-expect (pick 1234 5678) 1234)
; ===============
(check-expect (add "kirk" 0 "leaf")
              (make-node "kirk" 0 "leaf" "leaf"))
(check-expect (add (make-node "kirk"
                              0
                              (make-node "bones" 1 "leaf" "leaf")
                              (make-node "spock" 2 "leaf" "leaf"))
                   "data" 3)
              (make-node "kirk"
                         0
                         (make-node "bones" 1 "leaf" (make-node "data" 3 "leaf" "leaf"))
                         (make-node "spock" 2 "leaf" "leaf"))
              "data")