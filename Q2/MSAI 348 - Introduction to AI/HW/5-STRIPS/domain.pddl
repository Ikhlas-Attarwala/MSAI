(define
    (domain sokorobotto)
    (:requirements :typing)
    
    (:types
        shipment location - loadzone
        order - system
        robot pallette saleitem - tangible)
    
    (:predicates
        (includes
            ?s - shipment
            ?i - saleitem)
        (ships
            ?s - shipment
            ?o - order)
        (orders
            ?o - order
            ?i - saleitem)
        (unstarted
            ?s - shipment)
        (packing-location
            ?l - location)
        (available
            ?l - location)
        (contains
            ?p - pallette
            ?i - saleitem)
        (free
            ?r - robot)
        (connected
            ?l1 - location
            ?l2 - location)
        (at
            ; t incl. robot & pallette
            ?t - tangible
            ?l - location)
        (no-robot
            ?l - location)
        (no-pallette
            ?l - location)
        ; carrying : pallette is now with robot
        (carrying
            ?r - robot
            ?p - pallette)
    )
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; move_alone
    ; ?r moves from ?l1 to ?l2
    (:action move_alone
        :parameters
            (
                ?r - robot
                ?l1 - location
                ?l2 - location
            )
        :precondition
            (and
                (free ?r)
                
                (at ?r ?l1)
                (not (no-robot ?l1))
                (not (at ?r ?l2))
                (no-robot ?l2)
                
                (connected ?l1 ?l2)
                (connected ?l2 ?l1)
            )
        :effect
            (and
                (not (at ?r ?l1))
                (no-robot ?l1)
                (at ?r ?l2)
                (not (no-robot ?l2))
            )
    )
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; pickup
    ; free ?r picks up ?p from ?l2 and is no longer free
    (:action pickup
        :parameters
            (
                ?r - robot
                ?l2 - location
                ?p - pallette
                ?i - saleitem
            )
        :precondition
            (and
                (free ?r)
                (at ?r ?l2) ;remember, ?l2 is any location
                (not (no-robot ?l2))
                
                (at ?p ?l2)
                (not (no-pallette ?l2))
            )
        :effect
            (and
                (not (free ?r))
                (carrying ?r ?p)
            )
    )
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; move_with
    ; ?r moves with ?p to ?l1 from ?l2 and is not free
    (:action move_with
        :parameters
            (
                ?r - robot
                ?p - pallette
                ?l2 - location
                ?l1 - location
            )
        :precondition
            (and
                (not (free ?r))
                ; (not (at ?p ?l2)) ;why prob #6 was passing & #4 was failing
                ; (no-pallette ?l2)
                (carrying ?r ?p)

                (at ?r ?l2)
                (not (no-robot ?l2))
                (not (at ?r ?l1))
                (no-robot ?l1)
                
                (at ?p ?l2)
                (not (no-pallette ?l2))
                (not (at ?p ?l1)) ;careful
                (no-pallette ?l1) ;careful

                (connected ?l2 ?l1)
                (connected ?l1 ?l2)
            )
        :effect
            (and
                (not (at ?r ?l2))
                (no-robot ?l2)
                (at ?r ?l1)
                (not (no-robot ?l1))

                (not (at ?p ?l2))
                (no-pallette ?l2)
                (at ?p ?l1)
                (not (no-pallette ?l1))
            )
    )
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; dropoff
    ; ?r drops off ?p at available ?l1. ?r is free again
    (:action dropoff
        :parameters
            (
                ?r - robot
                ?p - pallette
                ?l1 - location
            )
        :precondition
            (and
                (not (free ?r))
                (carrying ?r ?p)
                
                (at ?r ?l1)
                (not (no-robot ?l1))
                
                (at ?p ?l1)
                (not (no-pallette ?l1))
                
                (available ?l1) ;careful
                (packing-location ?l1)
            )
        :effect
            (and
                (free ?r)
                (not (carrying ?r ?p))
                
            )
    )
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; pack
    ; ?p at ?l1. ?l1 info
    (:action pack
        :parameters
            (
                ?s - shipment
                ?l1 - location
            )
        :precondition
            (and
                (available ?l1)
                (packing-location ?l1)
                (unstarted ?s)
            )
        :effect
            (and
                (not (available ?l1))
                (not (packing-location ?l1))
                (not (unstarted ?s))
            )
    )
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; load
    ; ?l1 changes. pack ?i into ?s/?o from ?p at ?l1
    (:action load
        :parameters
            (
                ?r - robot
                ?p - pallette
                ?l1 - location
                ; ?l2 - location
                ?s - shipment
                ?o - order
                ?i - saleitem
            )
        :precondition
            (and
                (not (packing-location ?l1))
                (not (available ?l1))
                (not (unstarted ?s))
                
                (at ?p ?l1)
                (contains ?p ?i)
                (orders ?o ?i)
                (ships ?s ?o)
            )
        :effect
            (and
                (available ?l1)
                (packing-location ?l1)
                (not (contains ?p ?i))
                (includes ?s ?i)
                
                ; #6 still passed...
            )
    )
)
