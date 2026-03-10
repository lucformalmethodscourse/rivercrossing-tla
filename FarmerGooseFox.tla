-------------------------- MODULE FarmerGooseFox  --------------------------

VARIABLES 
  farmer,
  beans,
  goose,
  fox

vars == { farmer, beans, goose, fox }

Here == FALSE

There == TRUE

TypeOK == \A a \in vars : a \in { Here, There }

Safe ==
        \/ goose = farmer
        \/ goose # fox /\ goose # beans

Init ==
        /\ farmer = Here
        /\ beans = Here
        /\ goose = Here
        /\ fox = Here

Final == \A a \in vars : a = There

CrossesAlone ==
        /\ farmer' = ~ farmer
        /\ UNCHANGED << beans, goose, fox >>
        /\ Safe'

CrossesWithbeans ==
        /\ farmer = beans
        /\ farmer' = ~ farmer
        /\ beans' = ~ beans
        /\ UNCHANGED << goose, fox >>
        /\ Safe'

CrossesWithgoose ==
        /\ farmer = goose
        /\ farmer' = ~ farmer
        /\ goose' = ~ goose
        /\ UNCHANGED << beans, fox >>
        /\ Safe'

CrossesWithfox ==
        /\ farmer = fox
        /\ farmer' = ~ farmer
        /\ fox' = ~ fox
        /\ UNCHANGED << beans, goose >>
        /\ Safe'

Next ==
        \/ CrossesAlone
        \/ CrossesWithbeans
        \/ CrossesWithgoose
        \/ CrossesWithfox

\* TODO comment back in to see solution

Unsolved == TRUE

\* Unsolved == ~ Final

=============================================================================
\* based on yuriy's version
