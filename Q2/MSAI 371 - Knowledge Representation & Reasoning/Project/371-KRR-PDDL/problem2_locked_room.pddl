;;; PDDL Problem  file for murder mystery project
;;; Done for EECS 371
; Lock and key puzzle

; Author: Vyas Alwar

(define (problem body-in-locked-room)
    (:domain murder-mansion)
    (:objects butler heiress - person
              knife - weapon
              bedroom - room
              bedroomkey - key)
    (:init
        (dead heiress)
        (ownsWeapon butler knife)
        (ownsKey butler bedroomkey)
        (personCurrentlyInRoom heiress bedroom)
        (keyUnlocksRoom bedroomkey bedroom)
    )
    
    (:goal (hunch))
)
