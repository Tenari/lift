/-  *lift
|%
:: helpers
++  current-workout
  |=  state=state-0
  ^-  workout
  (rear history.state)
:: actions
++  start-workout
  |=  [state=state-0 =bowl:gall]
  ^-  (quip card state-0)
  ?:  =((lent history.state) 0)
    =.  history.state  (snoc history.state `workout`[lifts=*(list lift) start=now.bowl end=*@da])
    [~ state]
  =/  current=workout   (rear history.state)
  ?:  =(end.current *@da)
    [~ state]  :: do nothing if the last entry is not finished
  =.  history.state  (snoc history.state `workout`[lifts=*(list lift) start=now.bowl end=*@da])
  [~ state]
::
++  end-workout
  |=  [state=state-0 =bowl:gall]
  ^-  (quip card state-0)
  =/  current=workout   (rear history.state)
  ?:  (gth end.current *@da)   [~ state]  :: do nothing if the last workout is already ended
  =.  end.current       now.bowl
  =.  history.state     (snap history.state (dec (lent history.state)) current)
  [~ state]
::
++  add-lift
::  :lift &lift-action [%add-lift ~zod 1]
  |=  [=ex-id state=state-0 =bowl:gall]
  ^-  (quip card state-0)
  =/  current=workout   (rear history.state)
  ?>  =(end.current *@da) :: ensure that current workout is ongoing
  =.  lifts.current  (snoc lifts.current `lift`[ex-id sets=*(list lift-set)])
  =.  history.state  (snap history.state (dec (lent history.state)) current)
  [~ state]
::
++  add-set
::  :lift &lift-action [%add-set 0 [%reps 5 .100.0 2 %lbs '']]
  |=  [[index=@ud =lift-set] state=state-0 =bowl:gall]
  ^-  (quip card state-0)
  =/  current=workout   (rear history.state)
  ?>  =(end.current *@da) :: ensure that current workout is ongoing
  =/  thelift  (snag index lifts.current)
  =.  sets.thelift   (snoc sets.thelift lift-set)
  =.  lifts.current  (snap lifts.current index thelift)
  =.  history.state  (snap history.state (dec (lent history.state)) current)
  [~ state]
::
++  edit-exercise
::  :lift &lift-action [%edit-exercise [~zod 0] 'bench' %reps %bb '' '' '']
  |=  [new-ex=exercise state=state-0 =bowl:gall]
  ^-  (quip card state-0)
  ?>  (~(has by exercises.state) id.new-ex)
  =.  exercises.state   (~(put by exercises.state) id.new-ex new-ex)
  [~ state]
++  add-exercise
::  :lift &lift-action [%add-exercise [~zod 0] 'bench' %reps %bb '' '' '']
  |=  [new-ex=exercise state=state-0 =bowl:gall]
  ^-  (quip card state-0)
  =/  id=ex-id            [our.bowl next-ex-id.state]
  =.  id.new-ex           id
  =.  exercises.state     (~(put by exercises.state) id new-ex)
  =.  next-ex-id.state    +(next-ex-id.state)
  [~ state]
--
