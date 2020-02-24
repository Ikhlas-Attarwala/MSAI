;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 10-02-18) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


;; ==========================
; 10-02-18
;; ==========================

; note: ;;; = on board
;;; random notes

;;; 1) Data
;;; 2) Signature, Purpose, Header
;;; 3) Examples
;;; 4) Strategy
;;; 5) Body
;;; 6) Testing

;;; data with alternatives
;;; inerval data [0, 4]

;;; strategies: structural decomposition
;;;             decision tree
;;;             function composition
;;;             domain knowledge

;; ==========================

; a traffic-light-color is one of:
; - "red"
; - "yellow"
; - "green"
; - "flashing red"

;; signature>> next : traffic-light-color -> String
;; purpose>> produce the next color of the traffic light
;; header / strategy

#; ;template
(define (next tlc)
  (cond [(string=? tlc "red") (...)]
        [(string=? tlc "green") (...)]
        [(string=? tlc "yellow") (...)]
        [(string=? tlc "flashing red") (...)]))

;; examples
(check-expect (next "red") "green")
(check-expect (next "green") "yellow")
(check-expect (next "yellow") "red")
(check-expect (next "flashing red") "flashing red")
;; body
(define (next tlc)
  (cond [(string=? tlc "red") "green"]
        [(string=? tlc "green") "yellow"]
        [(string=? tlc "yellow") "red"]
        [(string=? tlc "flashing red") "flashing red"]))





