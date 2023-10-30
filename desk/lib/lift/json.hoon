/-  *lift
|%
++  dejs
  =,  dejs:format
  |%
  ++  action
    |=  jon=json
    ^-  ^action
    =<  (decode jon)
    |%
    ++  decode
      %-  of
      :~  [%start-workout (se %p)]
          [%end-workout (se %p)]
          [%add-lift de-ex-id]
          [%add-set index-and-set]
          [%add-exercise de-exercise]
          [%edit-exercise de-exercise]
          [%add-plan de-plan]
      ==
    ::
    ++  de-plan
      %-  of
      :~  [%program de-program]
          [%session de-session-plan]
      ==
    ::
    ++  de-program
      %-  ar
      day-plan-out
    ::
    ++  day-plan-out
      %-  of
      :~  [%rest ul]
          [%sessions (ar de-session-plan)]
      ==
    ::
    ++  de-session-plan
      %-  ot
      :~  [%name so]
          [%exercises (ar de-planned-exercise)]
      ==
    ::
    ++  de-planned-exercise
      %-  ot
      :~  [%ex-id de-ex-id]
          [%sets ni]
          [%reps ni]
          [%weight ne]
          [%rir ni]
          [%weight-increase ne]
          [%weight-increase-mode se-w-inc-mode]
          [%rep-increase ni]
      ==
    ::
    ++  de-exercise
      %-  ot
      :~  [%id de-ex-id]
          [%name so]
          [%mode se-ex-mode]
          [%equ se-eq-type]
          [%img so]
          [%description so]
          [%demonstration so]
      ==
    ::
    ++  de-ex-id
      %+  cu
        path-to-ex-id
      pa
    ::
    ++  path-to-ex-id
      |=  p=path
      ^-  ex-id
      [`@p`(slav %p +2:p) `@ud`(rash +6:p dem)]
    ::
    ++  index-and-set
      %-  ot
      :~  [%index ni]
          [%set de-set]
      ==
    ::
    ++  de-set
      %-  ot
      :~  [%mode se-ex-mode]
          [%reps ni]
          [%weight ne]
          [%weight-unit se-wu]
          [%rir ni]
          [%duration null-or-dri]
          [%distance ne]
          [%distance-unit se-du]
          [%note so]
      ==
    ::
    ++  se-w-inc-mode
      %+  cu
        |=  t=@tas
        ^-  ?(%linear %relative)
        ?+  t  !!
          %linear    %linear
          %relative  %relative
        ==
      (se %tas)
    ::
    ++  se-ex-mode
      %+  cu
        |=  t=@tas
        ^-  exercise-mode
        ?+  t  !!
          %reps  %reps
          %hold  %hold
          %dist  %dist
        ==
      (se %tas)
    ::
    ++  se-wu
      %+  cu
        |=  t=@tas
        ^-  weight-unit
        ?+  t  !!
          %lbs  %lbs
          %kg   %kg
        ==
      (se %tas)
    ::
    ++  se-du
      %+  cu
        |=  t=@tas
        ^-  distance-unit
        ?+  t  !!
          %in   %in
          %ft   %ft
          %mi   %mi
          %cm   %cm
          %m    %m
          %km   %km
        ==
      (se %tas)
    ::
    ++  se-eq-type
      %+  cu
        |=  t=@tas
        ^-  equipment-type
        ?+  t  !!
          %bb   %bb
          %db   %db
          %kb   %kb
          %bd   %bd
          %x    %x
          %ot   %ot
        ==
      (se %tas)
    ::
    ++  dri   :: specify in integer milliseconds, returns a @dr
      (cu |=(t=@ud ^-(@dr (div (mul ~s1 t) 1.000))) ni)
    ::
    ++  null-or-dri   :: specify in integer milliseconds, returns a @dr
      (cu |=(t=@ud ^-(@dr (div (mul ~s1 t) 1.000))) null-or-ni)
    ::
    ++  null-or-ni  :: accepts either a null or a n+'123', and converts nulls to 0, non-null to the appropriate number
      |=  jon=json
      ^-  @ud
      ?+  jon  !!
        [%n *]  (rash p.jon dem)
        ~       0
      ==
    ::
    --
  --
++  encode
  =,  enjs:format
  |%
    ++  en-plans
      |=  =plans
      ^-  json
      :-  %a
      %+  turn  plans
        |=  =plan
        ^-  json
        ?-  -.plan
          %program    (en-program +.plan)
          %session    (en-session-plan +.plan)
        ==
    ::
    ++  en-workouts
      |=  =history
      ^-  json
      :-  %a
      %+  turn  (flop history)
        |=  =workout
        ^-  json
        %-  pairs
        :~  lifts+a+(turn lifts.workout enlift)
            start+(time start.workout)
            end+?:(=(*@da end.workout) ~ (time end.workout))
        ==
    ::
    ++  en-exercises
      |=  =exercises
      ^-  json
      :-  %a
      %+  turn  ~(val by exercises)
        |=  =exercise
        ^-  json
        %-  pairs
        :~  id+(en-ex-id id.exercise)
            name+s+name.exercise
            mode+s+mode.exercise
            equ+s+equ.exercise
            img+s+img.exercise
            description+s+description.exercise
            demonstration+s+demonstration.exercise
        ==
    ::
    ++  en-ex-id
      |=  =ex-id
      ^-  json
      s+(spat [(scot %p ship.ex-id) (crip (en-json:html (numb num.ex-id))) ~])
    ++  en-program
      |=  =program
      ^-  json
      :-  %a
      %+  turn  program
        |=  =day-plan
        ?-  -.day-plan
          %rest  ~
          %sessions  a+(turn sessions.day-plan en-session-plan)
        ==
    ++  en-session-plan
      |=  sesh=session-plan
      ^-  json
      %-  pairs
      :~  name+s+name.sesh
          exercises+a+(turn exercises.sesh en-planned-exercise)
      ==
    ++  en-planned-exercise
      |=  p=planned-exercise
      ^-  json
      %-  pairs
      :~  id+(en-ex-id ex-id.p)
          sets+(numb sets.p)
          reps+(numb sets.p)
          weight+(numbrd weight.p)
          rir+(numb rir.p)
          weight-increase+(numbrd weight-increase.p)
          weight-increase-mode+s+weight-increase-mode.p
          rep-increase+(numb rep-increase.p)
      ==
    ++  enlift
      |=  =lift
      ^-  json
      %-  pairs
      :~  id+(en-ex-id id.lift)
          sets+a+(turn sets.lift enset)
      ==
    ++  enset
      |=  set=lift-set
      ^-  json
      ?-  -.set
        %reps
          %-  pairs
          :~  type+s+%reps
              reps+(numb reps.set)
              weight+(numbrd weight.set)
              rir+(numb rir.set)
              weight-unit+s+weight-unit.set
              note+s+note.set
          ==
        %hold
          %-  pairs
          :~  type+s+%hold
          :: TODO
          ==
        %dist
          %-  pairs
          :~  type+s+%dist
          :: TODO
          ==
      ==
    ::
    ++  numbrd
      |=  a=@rd
      ^-  json
      :-  %n
      (crip (flop (snip (snip (flop (trip (scot %rd a)))))))
    --
--
