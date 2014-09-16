#!/bin/bash
exec R --vanilla -q --slave -e "source(file=pipe(\"tail -n +4 $0\"))" --args $@
#debug: exec R --vanilla --verbose -e "source(file=pipe(\"tail -n +6 $0\"))" --args $@
#

require(rzmq)
require(RProtoBuf)


### protobuf data description

# load protobuf description
proto.files = c("../events/events.proto")
proto.dirs = c("../","../events/protobuf/","../events/")
.Call("readProtoFiles", proto.files, proto.dirs, PACKAGE = "RProtoBuf")
ls("RProtoBuf:DescriptorPool")


### zeromq networking

addr = "tcp://127.0.0.1:5556"


# start zmq serving
context = init.context()
socket = init.socket(context,"ZMQ_REP")
bind.socket(socket,addr)

# while(1) {
#       cat("server waiting to receive...\n")
#       msg = receive.socket(socket);
#           fun <- msg$fun
#           args <- msg$args
#           print(args)
#           ans <- do.call(fun,args)
#           send.socket(socket,ans);
#     }
# 


while(1) {
      cat("server waiting to receive...\n")
      msg = receive.socket(socket);


      ev = read( events.EventPrime, msg)

      cat(paste("server received event: ", ev, "\n"))
      #cat(as.character(ev))
      
      ## echo it back
      ev$Count = ev$Count + 1
      cat("server is echoing the same event back to client as the reply, with incremented Count field.")
      send.socket(socket, serialize(ev, NULL));
    }
