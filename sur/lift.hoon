|%
+$  opt-t           ?(~ @t)
+$  weight-unit     ?(%lbs %kg)
+$  exercise-mode   ?(%reps %hold)
:: barbell, dumbell, kettlebell, band, none, other
+$  equipment-type  ?(%bb %db %kb %bd %x %ot)
:: name and meta-data about a kind of thing you could actually do as a `lift`
+$  exercise   [id=@ name=@t mode=exercise-mode equ=equipment-type img=opt-t description=opt-t demonstration=opt-t]
+$  exercises  (map @ exercise)
+$  detail
  $%  [%text @t]
      [%date @da]
      [%amount @rs]
  ==
:: a lift is a record of an exercise you did during a workout
+$  lift      [exercise-id=@ sets=(list lift-set) details=(map @tas detail)]
+$  lift-set  [mode=exercise-mode reps=@ud weight=@rs rir=@ud =weight-unit duration=@dr]
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
