;;; PDDL Problem  file for murder mystery project
;;; Done for EECS 371
; Love triangle between butler and duke leads to his death
; Probable

; Author: Vyas Alwar

(define (problem probable-love-triangle-problem)
    (:domain murder-mansion)
    (:objects butler heiress duke - person
              knife - weapon
              livingroom - room)
    (:init
        (loves butler heiress)
        (loves duke heiress)
        (dead duke)
        (noLocationAlibi butler)
    )
    
    (:goal (probable))
)
