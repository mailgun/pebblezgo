#!/bin/bash
exec R --vanilla -q --slave -e "source(file=pipe(\"tail -n +4 $0\"))" --args $@
#debug: exec R --vanilla --verbose -e "source(file=pipe(\"tail -n +6 $0\"))" --args $@
#

require(rzmq)
require(RProtoBuf)

#### ===========================
#### protobuf data description
#### ===========================

# load protobuf description
gopath=Sys.getenv("GOPATH")
ourdir=paste(sep="",gopath,"/src/github.com/mailgun/pebblezgo/R")
setwd(ourdir)

proto.files = c("../events/events.proto")
proto.dirs = c("../","../events/protobuf/","../events/")
.Call("readProtoFiles", proto.files, proto.dirs, PACKAGE = "RProtoBuf")
ls("RProtoBuf:DescriptorPool")


#### ===========================
#### zeromq networking
#### ===========================

addr = "tcp://127.0.0.1:5556"

## start zmq serving
context = init.context()
socket = init.socket(context,"ZMQ_REP")
bound = bind.socket(socket,addr)
if (bound != TRUE) {
  stop(paste("could not bind address ", addr))
}



while(1) {
      cat("\nserver waiting to receive...\n")
      msg = receive.socket(socket, unserialize=FALSE);

      ## decode bytes, we have to supply the type.
      ev = read( events.EventPrime, msg)

      cat(paste("server received event: ", ev, "\n"))
      #cat(as.character(ev))
      
      ## echo it back
      ev$Count = ev$Count + 1
      cat("server is echoing the same event back to client as the reply, with incremented Count field.\n")
      send.socket(socket, serialize(ev, NULL), serialize=FALSE);
    }
