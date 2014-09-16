pebblezgo
=========

go example of the pebblez transport: protocol buffers over zeromq 

What is particularly attractive about this transport is that, in addition to being typesafe, it is usable from R. Oh yeah. And from every other language too.

http://cran.rstudio.com/web/packages/RProtoBuf/index.html

http://cran.rstudio.com/web/packages/rzmq/index.html


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

client sent '"hello 0 from client"'
server received 1 parts; parts[0]: 'hello 0 from client'
server created and sent response event ev = &events.EventPrime{Db:54.4, Count:0, Str:"Hello Events!", By:[]byte{0x1, 0x2, 0x3}, StrVec:[]string{"abc", "def"}, DbVec:[]float64{0.5, 2.5, 10.105}, XXX_unrecognized:[]byte(nil)}

client received reply 0, into EventPrime: &events.EventPrime{Db:54.4, Count:0, Str:"Hello Events!", By:[]byte{0x1, 0x2, 0x3}, StrVec:[]string{"abc", "def"}, DbVec:[]float64{0.5, 2.5, 10.105}, XXX_unrecognized:[]byte(nil)}
client printing as json: '{"Db":54.4,"Count":0,"Str":"Hello Events!","By":"AQID","StrVec":["abc","def"],"DbVec":[0.5,2.5,10.105]}'

client sent '"hello 1 from client"'
server received 1 parts; parts[0]: 'hello 1 from client'
server created and sent response event ev = &events.EventPrime{Db:54.4, Count:1, Str:"Hello Events!", By:[]byte{0x1, 0x2, 0x3}, StrVec:[]string{"abc", "def"}, DbVec:[]float64{0.5, 2.5, 10.105}, XXX_unrecognized:[]byte(nil)}

client received reply 1, into EventPrime: &events.EventPrime{Db:54.4, Count:1, Str:"Hello Events!", By:[]byte{0x1, 0x2, 0x3}, StrVec:[]string{"abc", "def"}, DbVec:[]float64{0.5, 2.5, 10.105}, XXX_unrecognized:[]byte(nil)}
client printing as json: '{"Db":54.4,"Count":1,"Str":"Hello Events!","By":"AQID","StrVec":["abc","def"],"DbVec":[0.5,2.5,10.105]}'

client sent '"hello 2 from client"'
server received 1 parts; parts[0]: 'hello 2 from client'
server created and sent response event ev = &events.EventPrime{Db:54.4, Count:2, Str:"Hello Events!", By:[]byte{0x1, 0x2, 0x3}, StrVec:[]string{"abc", "def"}, DbVec:[]float64{0.5, 2.5, 10.105}, XXX_unrecognized:[]byte(nil)}

...

~~~

#### docs for go-zmq bindings:
https://github.com/vaughan0/go-zmq

http://godoc.org/github.com/vaughan0/go-zmq

#### docs for gogoprotobuf:
https://code.google.com/p/gogoprotobuf/proto

http://godoc.org/code.google.com/p/gogoprotobuf/proto
