/-  *lift
/+  default-agent, dbug, lift-exercises, pokes=lift-actions, httplib=lift-http

%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this     .
    default  ~(. (default-agent this %|) bowl)
++  on-init
  ^-  (quip card _this)
  =.  exercises.state   (default-exercises:lift-exercises bowl)
  =.  next-ex-id.state  100 :: TODO actually tie to default-exercises count
  =.  defaults.state  [%lbs %mi]
  `this
++  on-save   !>(state)
++  on-load
  |=  old=vase
  ^-  (quip card _this)
  =.  state   *state-0
  =.  exercises.state  (default-exercises:lift-exercises bowl)
  =.  next-ex-id.state  100 :: TODO actually tie to default-exercises count
  =.  defaults.state  [%lbs %mi]
  ::`this(state !<(state-0 old))
  `this(state state)
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?:  =(%handle-http-request mark)
    =^  cards  state
    (handle:httplib !<([@ta =inbound-request:eyre] vase) state bowl) :: returns [cards state]
    [cards this]
  ?>  =(%lift-action mark)
  =/  act  !<(action vase)
  ?>  =(our.bowl src.bowl)
  =^  cards  state
  ?-  -.act
    %start-workout :: needs to return a list of cards and a new state
      (start-workout:pokes state bowl)
    %end-workout
      (end-workout:pokes state bowl)
    %add-lift
      (add-lift:pokes +.act state bowl)
    %add-set
      (add-set:pokes +.act state bowl)
    %edit-exercise
      (edit-exercise:pokes +.act state bowl)
    %add-exercise
      (add-exercise:pokes +.act state bowl)
    %add-plan
      (add-plan:pokes +.act state bowl)
  ==
  [cards this]
::
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?+  path  (on-peek:default path)
    [%x %history ~]
      ``history+!>(history)
    [%x %exercises ~]
      ``exercises+!>(exercises)
    [%x %plans ~]
      ``plans+!>(plans)
  ==
++  on-arvo   on-arvo:default
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+    path  (on-watch:default path)
    [%http-response *]
      `this
  ==
++  on-leave  on-leave:default
++  on-agent  on-agent:default
++  on-fail   on-fail:default
--
