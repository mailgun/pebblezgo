pebblezgo
=========

A golang example of the pebblez transport: protocol buffers (protobuf) over zeromq 

What is particularly attractive about this transport is that, in addition to being typesafe, it is usable from [R](http://www.r-project.org/). Oh yeah! Oh. And from every other language too.

http://cran.rstudio.com/web/packages/RProtoBuf/index.html

http://cran.rstudio.com/web/packages/rzmq/index.html

This project's [R subdirectory](https://github.com/mailgun/pebblezgo/tree/master/R) has examples of a client and server written in R.
This project's [pzclient](https://github.com/mailgun/pebblezgo/tree/master/pzclient) and [pzserver](https://github.com/mailgun/pebblezgo/tree/master/pzserver) 
directories have examples of a golang client and golang server.
The R servers and the Go servers talk to each just fine. Either can act as a server or client.


installation
-----------

#### first install the prerequisite, zeromq:
~~~
wget http://download.zeromq.org/zeromq-4.0.4.tar.gz
tar xf zeromq-4.0.4.tar.gz
cd zeromq-4.0.4
./configure
make && sudo make install
~~~

#### and install protocol buffers if need be
~~~
wget https://protobuf.googlecode.com/svn/rc/protobuf-2.6.0.tar.gz
tar xf protobuf-2.6.0.tar.gz
cd protobuf-2.6.0
./configure
make && sudo make install
~~~

#### then back in the pebblezgo
issuing the 'make' command will build and run the sample client and sample server
~~~
jaten@i7:~/go/src/github.com/mailgun/pebblezgo:master$ make
cd pzclient; go build pzclient.go
cd pzserver; go build pzserver.go
./pzserver/pzserver &
./pzclient/pzclient
client: connected to address 'tcp://127.0.0.1:5556'
server: bound address 'tcp://127.0.0.1:5556'
client sent '&events.EventPrime{Db:222.9, Count:0, Str:"originated by pzclient.go", By:[]byte{0x9}, StrVec:[]string{"yowzah"}, DbVec:[]float64{7.7, 5.5}, XXX_unrecognized:[]byte(nil)}'
server received 1 parts
server received into EventPrime: &events.EventPrime{Db:222.9, Count:0, Str:"originated by pzclient.go", By:[]byte{0x9}, StrVec:[]string{"yowzah"}, DbVec:[]float64{7.7, 5.5}, XXX_unrecognized:[]byte(nil)}
server created and sent response event ev = &events.EventPrime{Db:54.4, Count:0, Str:"Hello Events!", By:[]byte{0x1, 0x2, 0x3}, StrVec:[]string{"abc", "def"}, DbVec:[]float64{0.5, 2.5, 10.105}, XXX_unrecognized:[]byte(nil)}

client received reply 0, into EventPrime: &events.EventPrime{Db:54.4, Count:0, Str:"Hello Events!", By:[]byte{0x1, 0x2, 0x3}, StrVec:[]string{"abc", "def"}, DbVec:[]float64{0.5, 2.5, 10.105}, XXX_unrecognized:[]byte(nil)}
client printing as json: '{"Db":54.4,"Count":0,"Str":"Hello Events!","By":"AQID","StrVec":["abc","def"],"DbVec":[0.5,2.5,10.105]}'

client sent '&events.EventPrime{Db:222.9, Count:1, Str:"originated by pzclient.go", By:[]byte{0x9}, StrVec:[]string{"yowzah"}, DbVec:[]float64{7.7, 5.5}, XXX_unrecognized:[]byte(nil)}'
server received 1 parts
server received into EventPrime: &events.EventPrime{Db:222.9, Count:1, Str:"originated by pzclient.go", By:[]byte{0x9}, StrVec:[]string{"yowzah"}, DbVec:[]float64{7.7, 5.5}, XXX_unrecognized:[]byte(nil)}
server created and sent response event ev = &events.EventPrime{Db:54.4, Count:1, Str:"Hello Events!", By:[]byte{0x1, 0x2, 0x3}, StrVec:[]string{"abc", "def"}, DbVec:[]float64{0.5, 2.5, 10.105}, XXX_unrecognized:[]byte(nil)}

client received reply 1, into EventPrime: &events.EventPrime{Db:54.4, Count:1, Str:"Hello Events!", By:[]byte{0x1, 0x2, 0x3}, StrVec:[]string{"abc", "def"}, DbVec:[]float64{0.5, 2.5, 10.105}, XXX_unrecognized:[]byte(nil)}
client printing as json: '{"Db":54.4,"Count":1,"Str":"Hello Events!","By":"AQID","StrVec":["abc","def"],"DbVec":[0.5,2.5,10.105]}'

client sent '&events.EventPrime{Db:222.9, Count:2, Str:"originated by pzclient.go", By:[]byte{0x9}, StrVec:[]string{"yowzah"}, DbVec:[]float64{7.7, 5.5}, XXX_unrecognized:[]byte(nil)}'
server received 1 parts
server received into EventPrime: &events.EventPrime{Db:222.9, Count:2, Str:"originated by pzclient.go", By:[]byte{0x9}, StrVec:[]string{"yowzah"}, DbVec:[]float64{7.7, 5.5}, XXX_unrecognized:[]byte(nil)}
server created and sent response event ev = &events.EventPrime{Db:54.4, Count:2, Str:"Hello Events!", By:[]byte{0x1, 0x2, 0x3}, StrVec:[]string{"abc", "def"}, DbVec:[]float64{0.5, 2.5, 10.105}, XXX_unrecognized:[]byte(nil)}

client received reply 2, into EventPrime: &events.EventPrime{Db:54.4, Count:2, Str:"Hello Events!", By:[]byte{0x1, 0x2, 0x3}, StrVec:[]string{"abc", "def"}, DbVec:[]float64{0.5, 2.5, 10.105}, XXX_unrecognized:[]byte(nil)}
client printing as json: '{"Db":54.4,"Count":2,"Str":"Hello Events!","By":"AQID","StrVec":["abc","def"],"DbVec":[0.5,2.5,10.105]}'

client sent '&events.EventPrime{Db:222.9, Count:3, Str:"originated by pzclient.go", By:[]byte{0x9}, StrVec:[]string{"yowzah"}, DbVec:[]float64{7.7, 5.5}, XXX_unrecognized:[]byte(nil)}'
server received 1 parts
server received into EventPrime: &events.EventPrime{Db:222.9, Count:3, Str:"originated by pzclient.go", By:[]byte{0x9}, StrVec:[]string{"yowzah"}, DbVec:[]float64{7.7, 5.5}, XXX_unrecognized:[]byte(nil)}

...

~~~


#### docs for go-zmq bindings:
https://github.com/vaughan0/go-zmq

http://godoc.org/github.com/vaughan0/go-zmq

#### docs for gogoprotobuf:
https://code.google.com/p/gogoprotobuf/proto

http://godoc.org/code.google.com/p/gogoprotobuf/proto
