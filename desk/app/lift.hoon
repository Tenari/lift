/-  *lift
/+  default-agent, dbug, lift-exercises, lift-actions

%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this     .
    default  ~(. (default-agent this %|) bowl)
++  on-init
  ^-  (quip card _this)
  =.  exercises.state  (default-exercise-list:lift-exercises bowl)
  :_  this
  ~ :: list of cards goes here if we want to subscribe to anything (like maybe to pals?)
++  on-save   !>(state)
++  on-load
  |=  old=vase
  ^-  (quip card _this)
  `this(state !<(state-0 old))
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?>  ?=(%lift-action mark)
  =/  act  !<(action vase)
  ?.  =(our.bowl target.act)  !!
  =^  cards  state
  ?-  -.act
    %start-workout :: needs to return a list of cards and a new state
      (start-workout:lift-actions state bowl)
    %end-workout
      (end-workout:lift-actions state bowl)
  ==
  [cards this]
::
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?+  path  (on-peek:default path)
    [%x %history ~]
      ``noun+!>(history)
  ==
++  on-arvo   on-arvo:default
++  on-watch  on-watch:default
++  on-leave  on-leave:default
++  on-agent  on-agent:default
++  on-fail   on-fail:default
--
