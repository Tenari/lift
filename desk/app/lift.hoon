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
  =.  exercises.state  (default-exercise-list:lift-exercises bowl)
  =.  defaults.state  [%lbs %mi]
  :_  this
  :~  [%pass /eyre/connect %arvo %e %connect `/apps/lift %lift]
  ==
++  on-save   !>(state)
++  on-load
  |=  old=vase
  ^-  (quip card _this)
  `this(state !<(state-0 old))
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
