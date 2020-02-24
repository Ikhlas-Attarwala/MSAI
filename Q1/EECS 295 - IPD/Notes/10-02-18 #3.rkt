;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |10-02-18 #3|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


; a posn is:
;           (make-posn number number)

; distance : posn -> positive real
; to compute how far the posn is from the origin
(define (distance a-posn)
  (sqrt (+ (sqr (posn-x a-posn))
           (sqr (posn-y a-posn)))))

(check-expect (distance (make-posn 0 0)) 0)
(check-expect (distance (make-posn 3 4)) 5)
(check-within (distance (make-posn -1 -2))
              (sqrt 5)
              0.001)

;; ============== if we wanted to flip the #s

; flip : posn -> posn
; to flip 'a-posn' acoss the line y=x
(define (flip a-posn)
  (make-posn (posn-y a-posn)
             (posn-x a-posn)))

(check-expect (flip (make-posn 0 0)) (make-posn 0 0))
(check-expect (flip (make-posn 4 3)) (make-posn 3 4))
(check-expect (flip (make-posn -1 7)) (make-posn 7 -1))

;; ============== DEFINE STRUCT

; an animal is:
; - snake
; - ant
; - elephant

; an anima12 is
; - (make-snake number boolean boolean)
; - (make-ant number posn)
; - (make-elphant positive-real--number natura number)

(define (f-anima11 an-animal)
  (cond [(snake? an-animal) (f-snake an-animal)]
        [(ant? an-animal) (f-ant an-animal)]
        [(elephant? an-animal) (f-elephant an-animal)]))

(define (f-anima12 an-animal)
  (cond [(snake? an-animal) (snake-weight an-animal) ...
                            (snake-shedding? an-animal) ...
                            (snake-venomous? an-animal) ...]
        [(ant? an-animal) (ant-weight an-animal) ... (f-nposn (ant-loc an-animal))]
        [else (elephant-weight an-animal) ... (elephant-age an-animal)]))

; an elephant is
; (make-elephant positive-real-number natural-number)
(define-struct elephant (weight age))

; a snake is
; (make-snake number boolean boolean)
(define-struct snake (weight shedding? venomous?))
; snake-weight snake-shedding? snake-venomous? make-snake snake?

; f-posn : posn -> ????
(define (f-posn a-posn)
  ... (posn-x a-posn)
  ... (posn-y a-posn))


; f : snake -> ????
(define (f a-snake)
  (snake-weight a-snake) ...
  (snake-shedding? a-snake) ...
  (snake-venomous? a-snake) ...)

;; ======

; an ant is
; (make-ant number posn)
(define-struct ant (weight loc))
; ant-weight ant-loc make-ant ant?

; f : ant -> ????
(define (f an-ant)
  (ant-weight an-ant)
  (f-posn (ant-loc an-ant)))


;(define-struct posn (x, y))
; posn-x posn-y make-posn posn?





