#!/bin/bash
exec R --vanilla -q --slave -e "source(file=pipe(\"tail -n +4 $0\"))" --args $@
#debug: exec R --vanilla --verbose -e "source(file=pipe(\"tail -n +6 $0\"))" --args $@
#

require(rzmq)
require(RProtoBuf)

#### ===========================
#### protobuf data format
#### ===========================

gopath=Sys.getenv("GOPATH")
ourdir=paste(sep="",gopath,"/src/github.com/mailgun/pebblezgo/R")
setwd(ourdir)

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

## view packed up struct:
cat("client created event to send:\n")
cat(as.character(event))

## convert to bytes for transport
event.bytes = serialize(event, NULL)


#### ===========================
#### zeromq networking
#### ===========================

addr = "tcp://localhost:5556"

context = init.context()
socket = init.socket(context,"ZMQ_REQ")
connect.socket(socket,addr)

## send the bytes
send.socket(socket,data=event.bytes, serialize=FALSE)

## get a reply
ans = receive.socket(socket, unserialize=FALSE)

## decode the bytes into an EventPrime, using read()
event.ans = read( events.EventPrime, ans)

## view result
cat(paste("\n\nclient got back ans = \n", event.ans, "\n"))
vec = event.ans$DbVec

## we get a real R vector back.
cat("vec = \n")
str(vec) 
