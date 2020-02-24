;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |10-02-18 #2|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


(require 2htdp/universe)
(require 2htdp/image)

;; ================== INFO

; GameState is one of:
; - "game over"
; - radius

; a counter is
; - natural #1-number

; a radius is a a positiev


(define-struct game-state (time score))
;; ================== CONSTANTS
(define SHRINKING-RATE 4)
(define GROWING-RATE 1)
(define STARTING-RADIUS 200)
(define WIDTH (* 2.5 STARTING-RADIUS))
(define HEIGHT WIDTH)
(define MTS (empty-scene WIDTH HEIGHT))

; GS0 : GameState
(define GS0 STARTING-RADIUS)

;; ================== FUNCTIONS

;;signature>> draw : GameState -> Image
;;purpose>> return rendering of GameState as an image

;;;;;;;(define (draw a-gs)
  (cond ;[(not (number? a-gs "game over")) ...] <- also works
        [(number? a-gs) (overlay (circle a-gs "solid" "green")
                       MTS)]
        [else (overlay (above
                        (text "): GAME" 24 "red")
                        (text "OVER :(" 24 "red"))
                       MTS)]))

(check-expect (draw 100)
              (overlay (circle 100 "solid" "green")
                       MTS))

(check-expect (draw 60)
              (overlay (circle 60 "solid" "green")
                       MTS))

(check-expect (draw 0)
              (overlay (circle 0 "solid" "green")
                       MTS))

(check-expect (draw "game over")
              (overlay (above
                        (text "): GAME" 24 "red")
                        (text "OVER :(" 24 "red"))
                       MTS))

(check-expect (draw 0) MTS)

;;signaure>> tick : GameState -> GameState
;;purpose>> advance time by rate defined in CONSTANTS
#;(define (tick a-gs)
  ...)

;;signature>> mouse : GameState Number Number MEVT -> GameState
;;purpose>> click on the screen
#;(define (mouse a-gs x y mevt)
  ...)

#;(big-bang GS0
  (on-tick tick)
  (to-draw draw)
  (on-mouse mouse))