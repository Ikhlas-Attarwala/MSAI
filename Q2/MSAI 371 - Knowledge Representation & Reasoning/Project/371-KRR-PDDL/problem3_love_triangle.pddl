;;; PDDL Problem  file for murder mystery project
;;; Done for EECS 371
; Love triangle between butler and duke leads to his death
; Not provable

; Author: Vyas Alwar

(define (problem love-triangle-problem)
    (:domain murder-mansion)
    (:objects butler heiress duke - person
              knife - weapon)
    (:init
        (loves butler heiress)
        (loves duke heiress)
        (dead duke)
        (ownsWeapon butler knife)
    )
    
    (:goal (hunch))
)
