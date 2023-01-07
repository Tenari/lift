/-  *lift
|%
++  start-workout
  |=  [state=state-0 =bowl:gall]
  ^-  (quip card state-0)
  ?:  =(end:(rear history.state) *@da)
    [~ state]  :: do nothing if the last entry is not finished
  =.  history.state  (snoc history.state `workout`[lifts=*(list lift) start=now.bowl end=*@da])
  [~ state]
++  end-workout
  |=  [state=state-0 =bowl:gall]
  ^-  (quip card state-0)
  =/  current=workout   (rear history.state)
  ?:  (gth end.current *@da)   [~ state]  :: do nothing if the last workout is already ended
  =.  end.current       now.bowl
  =.  history.state     (snap history.state (dec (lent history.state)) current)
  [~ state]
--
