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
              weight+n+(scot %rs weight.set)
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
    --
--
