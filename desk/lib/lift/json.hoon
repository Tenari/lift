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
      ==
    ::
    ++  create-chat
      %-  ot
      :~  [%metadata (om so)]
          [%type (se %tas)]
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
      %+  turn  exercises
        |=  =exercise
        ^-  json
        %-  pairs
        :~  id+(en-ex-id id.exercise)
            name+s+name.exercise
            mode+s+mode.exercise
            equipment+s+equ.exercise
            img+s+img.exercise
            description+s+description.exercise
            demonstration+s+demonstration.exercise
        ==
    ::
    ++  en-ex-id
      |=  =ex-id
      ^-  json
      s+(spat [(scot %p ship.ex-id) (crip (en-json:html (numb num.ex-id))) ~])
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
