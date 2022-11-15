-------------------------- MODULE crossing1  --------------------------

VARIABLES 
  farmer,
  beans,
  goose,
  wolf

TypeOK == 
        /\ farmer \in BOOLEAN 
        /\ beans \in BOOLEAN 
        /\ goose \in BOOLEAN 
        /\ wolf \in BOOLEAN

Init == /\ farmer = FALSE
        /\ beans = FALSE
        /\ goose = FALSE
        /\ wolf = FALSE

Final == /\ farmer
         /\ beans
         /\ goose
         /\ wolf                       

CrossesAlone == /\ (farmer' = ~ farmer) 
                /\ UNCHANGED << beans, goose, wolf >>       

CrossesWithbeans ==  (farmer = beans)
                    /\ (farmer' = ~ farmer) 
                    /\ (beans' = ~ beans) 
                    /\ UNCHANGED << goose, wolf >>      

CrossesWithgoose == (farmer = goose)
                   /\ (farmer' = ~ farmer) 
                   /\ (goose' = ~ goose) 
                   /\ UNCHANGED << beans, wolf >>      

CrossesWithWolf ==  (farmer = wolf)
                   /\ (farmer' = ~ farmer) 
                   /\ (wolf' = ~ wolf) 
                   /\ UNCHANGED << beans, goose >>                                                      

Safe == (goose = farmer)
        \/ ( goose # wolf /\ goose # beans )        

Next == ( \/ CrossesAlone
          \/ CrossesWithbeans
          \/ CrossesWithgoose
          \/ CrossesWithWolf
        ) /\ Safe'

Unsolved == ~ Final

=============================================================================
\* Modification History
\* Last modified Thu Jan 28 18:18:05 PST 2016 by yuriy
\* Created Thu Jan 28 16:45:04 PST 2016 by yuriy