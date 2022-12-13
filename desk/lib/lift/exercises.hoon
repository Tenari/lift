/- *lift
|%
++  default-exercise-list
  |=  =bowl:gall
  ^-  (list exercise)
  :~  
  :*  id=[our.bowl 1]   name='Bench Press'      mode=%reps  equ=%bb
      img='https://i.imgur.com/tE9ejXE.jpg'
      description='Lay on flat bench; press barbell upward from chest.'
      demonstration='https://www.youtube.com/watch?v=vcBig73ojpE'
      ==
  :*  id=[our.bowl 2]   name='Back Squat'       mode=%reps  equ=%bb
      img='https://i.imgur.com/W7edOeL.jpg'
      description='Rest barbell on shoulders; squat all the way down and stand back up.'
      demonstration='https://www.youtube.com/watch?v=QhVC_AnZYYM'
      ==
  :*  id=[our.bowl 3]   name='Overhead Press'   mode=%reps  equ=%bb
      img='https://i.imgur.com/KcTSmES.jpg'
      description=~
      demonstration=~
      ==
  :*  id=[our.bowl 4]   name='Deadlift'         mode=%reps  equ=%bb
      img='https://i.imgur.com/idVNeKb.png'
      description=~
      demonstration=~
      ==
  :*  id=[our.bowl 5]   name='Pushup'           mode=%reps  equ=%x
      img='https://i.imgur.com/OxcVWoP.png'
      description='Lay belly-down on ground. Hold body flat, and push your hands into the ground, raising your body up.'
      demonstration=~
      ==
  :*  id=[our.bowl 6]   name='Pullup'           mode=%reps  equ=%ot
      img='https://i.imgur.com/vRgip4M.png'
      description=~
      demonstration=~
      ==
  :*  id=[our.bowl 7]   name='Plank'            mode=%hold  eq=%x
      img='https://i.imgur.com/hIlbxAH.jpg'
      description=~
      demonstration=~
      ==
  :*  id=[our.bowl 8]   name='Seated Concentration Curl'  mode=%reps  equ=%db
      img='https://i.imgur.com/IxRAFDy.jpg'
      description=~
      demonstration=~
      ==
  :*  id=[our.bowl 9]   name='Pendlay Row'      mode=%reps  equ=%bb
      img='https://i.imgur.com/cy3cf7J.jpg'
      description='Bend over the barbell and row it towards your chest.'
      demonstration=~
      ==
  :*  id=[our.bowl 10] name='Weighted Tibialis Raise'  mode=%reps  equ=%ot
      img=~
      description=~
      demonstration=~
      ==
  :*  id=[our.bowl 11] name='Wall Tibialis Raise'      mode=%reps  equ=%x
      img=~
      description=~
      demonstration=~
      ==
  :*  id=[our.bowl 12] name='Ab Roller'      mode=%dist  equ=%ot
      img=~
      description=~
      demonstration=~
      ==
  :*  id=[our.bowl 13] name='Shrugs'      mode=%reps  equ=%bb
      img=~
      description=~
      demonstration=~
      ==
  :*  id=[our.bowl 14] name='Farmer Carry'  mode=%dist  equ=%db
      img=~
      description=~
      demonstration=~
      ==
  :*  id=[our.bowl 15] name='Backward Farmer Carry'  mode=%dist  equ=%db
      img=~
      description=~
      demonstration=~
      ==
  :*  id=[our.bowl 16] name='Seated Good Morning'  mode=%reps  equ=%bb
      img=~
      description=~
      demonstration=~
      ==
  :*  id=[our.bowl 17] name='Reverse Crunch'  mode=%reps  equ=%x
      img=~
      description=~
      demonstration=~
      ==
  :*  id=[our.bowl 18] name='Elbow-on-knee Shoulder Rotator'  mode=%reps  equ=%db
      img='https://i.imgur.com/GnVLkoN.png'
      description=~
      demonstration='https://www.youtube.com/watch?v=7liuNxwqkRY'
      ==
  :*  id=[our.bowl 19] name='Straight-arm Horizontal Adduction'  mode=%reps  equ=%bd
      img='https://i.imgur.com/XJj26fv.jpg'
      description=~
      demonstration=~
      ==
  ==
++  default-exercises
  (~(gas by *(map @ exercise)) default-exercise-list)
--
