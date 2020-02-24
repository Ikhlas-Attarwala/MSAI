;;; PDDL Problem  file for murder mystery project
;;; Done for EECS 371
; Simplest case imaginable
; The butler stabs the only other person

; Author: Vyas Alwar

(define (problem the-butler-did-it)
    (:domain murder-mansion)
    (:objects butler heiress - person
              knife - weapon)
    (:init
        (bloodied knife)
        (dead heiress)
        (ownsWeapon butler knife)

        ; I have this here to avoid dealing with space for now
        (knownWeapon knife)
    )
    
    (:goal (hunch))
)
