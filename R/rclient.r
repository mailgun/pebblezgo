#!/bin/bash
exec R --vanilla -q --slave -e "source(file=pipe(\"tail -n +4 $0\"))" --args $@
#debug: exec R --vanilla --verbose -e "source(file=pipe(\"tail -n +6 $0\"))" --args $@
#

### protobuf data format

require(RProtoBuf)
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
cat(as.character(event))


### zeromq networking

require(rzmq)
addr = "tcp://localhost:5556"

context = init.context()
socket = init.socket(context,"ZMQ_REQ")
connect.socket(socket,addr)





 

#send.socket(socket,data=list(fun=sqrt,args=list(64)))
send.socket(socket,data=list(event))
ans = receive.socket(socket)
ans

cat(paste("client got back ans = ", ans, "\n"))
#ans = remote.exec(socket,sqrt,10000)
