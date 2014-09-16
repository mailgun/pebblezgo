#!/bin/bash
exec R --vanilla -q --slave -e "source(file=pipe(\"tail -n +4 $0\"))" --args $@
#debug: exec R --vanilla --verbose -e "source(file=pipe(\"tail -n +6 $0\"))" --args $@
#

require(rzmq)
require(RProtoBuf)

### protobuf data format

proto.files = c("../events/events.proto")
proto.dirs = c("../","../events/protobuf/","../events/")
.Call("readProtoFiles", proto.files, proto.dirs, PACKAGE = "RProtoBuf")

ls("RProtoBuf:DescriptorPool")

event <- new(events.EventPrime)

event$Db = 33333.11
event$Count = 76
event$Str = "rclient.r says hello"
event$StrVec = c("abc","xyz","lmnop")
event$DbVec = c(1.1,2.2, 3.3)

# view packed up struct:
cat("client created event to send:\n")
cat(as.character(event))


### zeromq networking

addr = "tcp://localhost:5556"

context = init.context()
socket = init.socket(context,"ZMQ_REQ")
connect.socket(socket,addr)




event.bytes = serialize(event, NULL)
 

#send.socket(socket,data=list(fun=sqrt,args=list(64)))
send.socket(socket,data=event.bytes)
ans = receive.socket(socket)

event.ans = read( events.EventPrime, ans)

cat(paste("\n\nclient got back ans = \n", event.ans, "\n"))

vec = event.ans$DbVec

cat("vec = \n")
str(vec)
