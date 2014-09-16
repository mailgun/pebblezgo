#!/bin/bash
exec R --vanilla -q --slave -e "source(file=pipe(\"tail -n +4 $0\"))" --args $@
#debug: exec R --vanilla --verbose -e "source(file=pipe(\"tail -n +6 $0\"))" --args $@
#

require(RProtoBuf)
require(rzmq)

addr = "tcp://localhost:5556"

substitute(expr)
context = init.context()
socket = init.socket(context,"ZMQ_REQ")
connect.socket(socket,addr)

send.socket(socket,data=list(fun=sqrt,args=list(64)))
ans = receive.socket(socket)
ans

cat(paste("client got back ans = ", ans, "\n"))
#ans = remote.exec(socket,sqrt,10000)
