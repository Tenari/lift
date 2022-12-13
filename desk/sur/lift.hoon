|%
+$  ex-id           [=ship @ud]
+$  weight-unit     ?(%lbs %kg)
+$  distance-unit   ?(%in %ft %mi %cm %m %km)
+$  exercise-mode   ?(%reps %hold %dist)
:: barbell, dumbell, kettlebell, band, none, other
+$  equipment-type  ?(%bb %db %kb %bd %x %ot)
:: name and meta-data about a kind of thing you could actually do as a `lift`
+$  exercise   [id=ex-id name=@t mode=exercise-mode equ=equipment-type img=(unit @t) description=(unit @t) demonstration=(unit @t)]
+$  exercises  (map @ exercise)
+$  detail
  $%  [%text @t]
      [%date @da]
      [%amount @rs]
  ==
:: a lift is a record of an exercise you did during a workout
+$  lift      [id=ex-id sets=(list lift-set) details=(map @tas detail)]
+$  lift-set
  $?  [mode=exercise-mode reps=@ud weight=@rs rir=@ud =weight-unit]                   :: mode=%reps
      [mode=exercise-mode weight=(unit @rs) =weight-unit duration=@dr]                :: mode=%hold
      [mode=exercise-mode weight=(unit @rs) =weight-unit distance=@rs =distance-unit] :: mode=%dist
  ==
+$  workout   [lifts=(list lift) start=@da end=@da]
+$  history   (list workout)
+$  action
  $%  [%start-workout target=@p]
      [%end-workout target=@p]
      [%add-lift target=@p name=@t]
      [%edit-lift target=@p =lift]
      [%remove-lift target=@p]
      [%add-exercise target=@p]
      [%remove-exercise target=@p]
  ==
--
