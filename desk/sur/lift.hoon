|%
+$  card  card:agent:gall
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  [%0 =history =exercises defaults=[=weight-unit =distance-unit]]
  ==
+$  ex-id           [=ship num=@ud]
+$  weight-unit     ?(%lbs %kg)
+$  distance-unit   ?(%in %ft %mi %cm %m %km)
+$  exercise-mode   ?(%reps %hold %dist)
:: barbell, dumbell, kettlebell, band, none, other
+$  equipment-type  ?(%bb %db %kb %bd %x %ot)
:: name and meta-data about a kind of thing you *could* actually do as a `lift`
+$  exercise   [id=ex-id name=@t mode=exercise-mode equ=equipment-type img=@t description=@t demonstration=@t]
+$  exercises  (list exercise)
:: a lift is a record of an exercise you did during a workout
+$  lift-set
  $:
    mode=exercise-mode
    reps=@ud
    weight=@rd
    =weight-unit
    rir=@ud
    duration=@dr
    distance=@rd
    =distance-unit
    note=@t
  ==
+$  lift      [id=ex-id sets=(list lift-set)]
+$  workout   [lifts=(list lift) start=@da end=@da]
+$  history   (list workout)
+$  action
  $%  [%start-workout target=@p]
      [%end-workout target=@p]
      [%add-lift =ex-id]
      [%add-set index=@ud =lift-set] :: index is the lift index within the lifts.workout list
::      [%edit-lift target=@p =lift]
::      [%remove-lift target=@p]
::      [%add-exercise target=@p]
::      [%remove-exercise target=@p]
  ==
--
