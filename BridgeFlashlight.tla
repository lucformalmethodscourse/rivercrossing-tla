-------------------------- MODULE BridgeFlashlight  --------------------------

\* terminates after everybody has crossed => disable check for deadlock

EXTENDS TLC, Naturals

CONSTANTS 
        \* these are model values, i.e., symbols identical only to themselves
        HUEY, DEWEY, LOUIE, DONALD, MAGLITE

VARIABLES 
  near, \* set of objects on the near side
  far,  \* set of objects on the far side
  time  \* remaining time in terms of battery life of flashlight 

CrossingTimes == ( HUEY :> 1 @@ DEWEY :> 2 @@ LOUIE :> 5 @@ DONALD :> 10 )
Adventurers == DOMAIN CrossingTimes
Flashlight == MAGLITE
InitialBatteryLife == 17

TypeOK == 
        /\ near \union far \subseteq Adventurers \union {Flashlight} 
        /\ time \in Nat

Init == 
        /\ near = Adventurers \union {Flashlight}
        /\ far = {}
        /\ time = InitialBatteryLife

CanSee == time >= 0

Final == Adventurers \subseteq far

People(here) == here \ {Flashlight}

OneCrosses(here, there) == 
        /\ Flashlight \in here
        /\ \E a \in People(here) :
                /\ time' = time - CrossingTimes[a] 
                /\ here' = here \ {a, Flashlight}
                /\ there' = there \union {a, Flashlight}
        /\ CanSee'

Max(x, y) == IF x > y THEN x ELSE y

TwoCross(here, there) == 
        /\ Flashlight \in here
        /\ \E a, b \in People(here) : 
                /\ a # b
                /\ time' = time - Max(CrossingTimes[a], CrossingTimes[b])
                /\ here' = here \ {a, b, Flashlight}
                /\ there' = there \union {a, b, Flashlight}
        /\ CanSee'

Next == 
        \/ TwoCross(near, far)
        \/ TwoCross(far, near)
        \/ OneCrosses(far, near)
        \/ OneCrosses(near, far)

\* TODO comment back in to see solution
\* Unsolved == ~ Final

=============================================================================
