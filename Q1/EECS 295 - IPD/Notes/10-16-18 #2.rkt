;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |10-16-18 #2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


;;; STACK ADT
;;; ---------

; » 1 2 3»

; ======== SIGNATURES:
; empty-stack? : Stack -> Boolean
; push : Element Stack -> Stack
; get-top : Stack -> Element
; pop : Stack -> Stack


; ======== LAWS:
; (empty-stack? |») => #true
; (empty-stack? |a0 a1 ...») => #false
; (push b |a0 ...») => |a0 ... b»
; (get-top |») => ERROR
; (get-top |a0 ... ak») => ak
; (pop |») => ERROR
; (pop |a0 ... ak») => |a0 ... a{k-1}»

;|a0 a1 a2 » = (list a2 a1 a0)

; empty-stack? = empty?
; push = cons
; get-top = first
; pop = rest