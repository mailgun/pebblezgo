#!/bin/bash
exec R --vanilla -q --slave -e "source(file=pipe(\"tail -n +4 $0\"))" --args $@
#debug: exec R --vanilla --verbose -e "source(file=pipe(\"tail -n +6 $0\"))" --args $@
#

require(RProtoBuf)
require(rzmq)

addr = "tcp://127.0.0.1:5556"

context = init.context()
socket = init.socket(context,"ZMQ_REP")
bind.socket(socket,addr)

while(1) {
      cat("server waiting to receive...\n")
      msg = receive.socket(socket);
          fun <- msg$fun
          args <- msg$args
          print(args)
          ans <- do.call(fun,args)
          send.socket(socket,ans);
    }

