-------------------------- MODULE BridgeFlashlight  --------------------------

EXTENDS TLC, Integers

VARIABLES 
  near,
  far,
  light

\* crossing times for each adventurer
Times == ( "huey" :> 1 @@ "dewey" :> 2 @@ "louie" :> 5 @@ "donald" :> 10 )
Adventurers == DOMAIN Times
Flashlight == "maglite"
InitialBatteryLife == 30

TypeOK == near \union far \subseteq Adventurers \union {Flashlight} /\ light \in Int

Init == 
        /\ near = Adventurers \union {Flashlight}
        /\ far = {}
        /\ light = InitialBatteryLife

Final == Adventurers \subseteq far /\ light >= 0

People(here) == here \ {Flashlight}

OneCrosses(here, there) == 
        /\ Flashlight \in here
        /\ \E a \in People(here):
                /\ light' = light - Times[a] 
                /\ here' = here \ {a, Flashlight}
                /\ there' = there \union {a, Flashlight}

Max(x, y) == IF x > y THEN x ELSE y

TwoCross(here, there) == 
        /\ Flashlight \in here
        /\ \E a, b \in People(here) : 
                /\ a # b
                /\ light' = light - Max(Times[a], Times[b])
                /\ here' = here \ {a, b, Flashlight}
                /\ there' = there \union {a, b, Flashlight}

Next == 
        \/ TwoCross(near, far)
        \/ OneCrosses(far, near)

\* Unsolved == ~ Final

=============================================================================
