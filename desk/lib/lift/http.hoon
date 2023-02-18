/-  *lift
/+  server, schooner
/*  lift-ui  %html  /app/lift-ui/html
|%
++  handle
  |=  [[eyre-id=@ta =inbound-request:eyre] state=state-0 =bowl:gall]
  ^-  (quip card state-0)
  =/  ,request-line:server
      (parse-request-line:server url.request.inbound-request)
  =+  send=(cury response:schooner eyre-id)
  ?.  authenticated.inbound-request
    [(send [302 ~ [%login-redirect '/apps/lift']]) state]
  ?+  method.request.inbound-request  [(send [405 ~ [%stock ~]]) state]  :: default is 405
    %'GET' :: we only respond positively to GET requests for now
      ?+  site  [(send [404 ~ [%plain "404 - Not Found"]]) state]
        [%apps %lift ~]  ::  Send the ui HTML
          [(send [200 ~ [%html lift-ui]]) state]
      ==
  ==
--
