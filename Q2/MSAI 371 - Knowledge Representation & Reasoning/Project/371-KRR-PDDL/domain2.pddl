;;; PDDL Domain file for murder mystery project
;;; Done for EECS 371
; Implements movement between rooms

; Author: Vyas Alwar

(define (domain murder-mansion)
  (:requirements :strips :typing)
  
 (:types weapon key - object
         person - agent
         room - location)
    
 (:predicates
    ; Knowledge about killing and victims
    (dead ?victim - person)

    (motive ?suspect - person)
    (means ?suspect - person)
    (suspicious ?suspect - person)
  
    ; Weapons
    (knownWeapon ?w - weapon)
    (weaponIsMurderWeapon ?w - weapon)
    (ownsWeapon ?owner - person ?w - weapon)
    (bloodied ?w - weapon)
    (fingerprintsOnWeapon ?w - weapon ?p - person)
    
    ;Reasoning About Locations
    (objectInRoom ?o - object ?r - room)
    (knownObjectInRoom ?o - object ?r - room)
   
    (personTypicallyFoundInRoom ?p - person ?r - room)
    (personCurrentlyInRoom ?p - person ?r - room)
    (personInRoomDuringMurder ?p - person ?r - room)

    ; Movement and connectedness of rooms
    (detectiveCurrentlyInRoom ?r - room)
    (roomConnected ?r1 - room ?r2 - room)
    
    ; Lock and Key puzzles
    (keyUnlocksRoom ?k - key ?r - room)
    (ownsKey ?owner - person ?k - key)
    
    ; Alibis
    (interrogatedPerson ?p - person) 
    (personInDifferentRoomAlibi ?p - person ?r - room)
    (personWithDifferentPersonAlibi ?p - person ?corroborator - person)
    (noLocationAlibi ?p - person)
    (noCorroborationAlibi ?p - person)
    
    ; Moods
    (scared ?p - person)
   	(happy ?p - person)
    (sad ?p - person)
	(calm ?p - person)
    (worried ?p - person)
    
    ; Interpersonal Relationships
    (hates ?hater - person ?hated - person)
    (loves ?lover - person ?loved - person)
    (envies ?envier - person ?envied - person)
    
    ; Different end states indicating certainty
    (solved) ; The crime is solved beyond a reasonable doubt (means+motive+suspicious)
    (probable) ; There is some degree of certainty that the crime is solved (pick 2)
    (hunch) ; We have a hunch that the murder can be solved, but we might be wrong
 )

 ; Movement
 (:action MoveBetweenRooms
   :parameters (?currentroom - room ?nextroom - room)
   :precondition (and (detectiveCurrentlyInRoom ?currentroom)
                      (roomConnected ?currentroom ?nextroom))
   :effect (and (not (detectiveCurrentlyInRoom ?currentroom))
                (detectiveCurrentlyInRoom ?nextroom))
 )

;; Access to the murder weapon gives means
(:action BloodiedWeaponIsMurderWeapon
    :parameters (?w - weapon)
    :precondition (and (bloodied ?w) (knownWeapon ?w)) 
    :effect (weaponIsMurderWeapon ?w)
 )

(:action OwningMurderWeaponGivesMeans
    :parameters (?owner - person ?w - weapon)
    :precondition (and (ownsWeapon ?owner ?w)
                       (weaponIsMurderWeapon ?w))
    :effect (means ?owner)
 )

(:action ProximityToWeaponGivesMeans
    :parameters (?p - person ?r - room ?w - weapon)
    :precondition (and (personTypicallyFoundInRoom ?p ?r)
                       (weaponIsMurderWeapon ?w)
                       (knownObjectInRoom ?w ?r))
    :effect (means ?p)
 )

(:action FingerPrintsOnWeaponGivesMeans
    :parameters (?p - person ?w - weapon)
    :precondition (and (weaponIsMurderWeapon ?w)
                       (fingerprintsOnWeapon ?w ?p))
    :effect (means ?p)
 )

;; Misleading or false alibis raise suspicion
 (:action LocationAlibiDoesNotCorroborateIsSuspicious
    :parameters (?p1 - person ?p2 - person)
    :precondition (and (interrogatedPerson ?p1) 
                       (interrogatedPerson ?p2)
                       (personWithDifferentPersonAlibi ?p1 ?p2)
                       (not (personWithDifferentPersonAlibi ?p2 ?p1)))
    :effect (and (suspicious ?p1) (suspicious ?p2))
 )

(:action NoLocationAlibiIsSuspicious
    :parameters (?p1 - person)
    :precondition (and (interrogatedPerson ?p1)
                       (noLocationAlibi ?p1))
    :effect (suspicious ?p1)
 )

(:action ScaredDuringInterrogationIsSuspicious
    :parameters (?p - person)
    :precondition (and (interrogatedPerson ?p)
                       (scared ?p))
    :effect (suspicious ?p)
 )

; Investigating Actions. 
; Necessary for establishing the logical flow of the actions
 (:action InvestigateRoom
           :parameters (?o - object ?r - room)
           :precondition (and (detectiveCurrentlyInRoom ?r)
                              (objectInRoom ?o ?r))
           :effect (knownObjectInRoom ?o ?r))

 (:action InterrogatePerson
           :parameters (?p - person ?r - room)
           :precondition (and (not (interrogatedPerson ?p))
                              (personCurrentlyInRoom ?p ?r)
                              (detectiveCurrentlyInRoom ?r))
           :effect (interrogatedPerson ?p)
 )
           
 (:action IdentifyWeapon
   :parameters (?w - weapon ?r - room)
   :precondition (knownObjectInRoom ?w ?r)
   :effect (knownWeapon ?w)
 )


 ;; I might change this to (suspicious ?keyowner)
 ;; I'm not sure how damning this evidence is.
(:action DiscoverKeyOwnerIsKiller
           :parameters (?keyowner - person ?victim - person ?k - key ?r - room)
           :precondition (and (personCurrentlyInRoom ?victim ?r)
                              (dead ?victim)
                              (keyUnlocksRoom ?k ?r)
                              (ownsKey ?keyowner ?k))
           :effect (suspicious ?keyowner))

;; Determine interpersonal relationships 
 (:action LoveTriangleCausesHatred
           :parameters (?p1 - person ?p2 - person ?p3 - person)
           :precondition (and (loves ?p1 ?p2)
                              (loves ?p3 ?p2)
                              (or (interrogatedPerson ?p1) 
                                  (interrogatedPerson ?p2)
                                  (interrogatedPerson ?p3)))

           :effect (and (hates ?p1 ?p3)
                   (hates ?p3 ?p1))
  )
  
  ; Motive Inference
  (:action HateIsAMotive
    :parameters (?hater - person ?hated - person)
    :precondition (and (hates ?hater ?hated) 
                       (dead ?hated)
                       (interrogatedPerson ?hater))
    :effect (motive ?hater)
  )
  
  (:action EnvyIsAMotive
    :parameters (?envier - person ?envied - person)
    :precondition (and (envies ?envier ?envied)
                       (dead ?envied)
                       (interrogatedPerson ?envier))
    :effect (motive ?envier)
  )
  
  ; Solutions
  (:action MeansMotiveSuspiciousImpliesGuilt
    :parameters (?suspect - person)
    :precondition (and (means ?suspect) (motive ?suspect) (suspicious ?suspect))
    :effect (solved)
  )
  
  (:action MeansMotiveImpliesProbable
    :parameters (?suspect - person)
    :precondition (and (means ?suspect) (motive ?suspect))
    :effect (probable)
  )
  
  (:action MeansSuspiciousImpliesProbable
    :parameters (?suspect - person)
    :precondition (and (means ?suspect) (suspicious ?suspect))
    :effect (probable)
  )
  
  (:action SuspiciousMotiveImpliesProbable
    :parameters (?suspect - person)
    :precondition (and (motive ?suspect) (suspicious ?suspect))
    :effect (probable)
  )
  
    (:action AnyClueImpliesHunch
    :parameters (?suspect - person)
    :precondition (or (means ?suspect) (motive ?suspect) (suspicious ?suspect))
    :effect (hunch)
  )
)
