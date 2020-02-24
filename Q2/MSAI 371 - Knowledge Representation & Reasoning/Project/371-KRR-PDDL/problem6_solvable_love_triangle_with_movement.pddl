;;; PDDL Problem  file for murder mystery project
;;; Done for EECS 371
; Love triangle between butler and duke leads to his death
; Provable, with basic movement mechanics

; Author: Vyas Alwar

(define (problem love-triangle-solvable-movement)
    (:domain murder-mansion)
    (:objects butler heiress duke - person
              knife - weapon
              livingroom foyer - room)
    (:init
        (detectiveCurrentlyInRoom foyer)
        (roomConnected foyer livingroom)
        
        (loves butler heiress)
        (loves duke heiress)
        (dead duke)
        (ownsWeapon butler knife)
        (bloodied knife)
        (objectInRoom knife livingroom)
        (noLocationAlibi butler)
        (personCurrentlyInRoom butler livingroom)
    )
    
    (:goal (solved))
)
