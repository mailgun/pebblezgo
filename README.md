pebblezgo
=========

A golang example of the pebblez transport: protocol buffers (protobuf) over zeromq 

What is particularly attractive about this transport is that, in addition to being typesafe, it is usable from [R](http://www.r-project.org/). Oh yeah! Oh. And from every other language too.

http://cran.rstudio.com/web/packages/RProtoBuf/index.html

http://cran.rstudio.com/web/packages/rzmq/index.html

This project's [R subdirectory](https://github.com/mailgun/pebblezgo/tree/master/R) has examples of a client and server written in R.
This project's [pzclient](https://github.com/mailgun/pebblezgo/tree/master/pzclient) and [pzserver](https://github.com/mailgun/pebblezgo/tree/master/pzserver) 
directories respectively have examples of a golang client and golang server.
The R servers and the Go servers readily talk to each other, and either can act in either role.


installation
-----------

Note: known-to-work versions (binary backups) of the following source packages
are stored in the vendored/ subdirectory.

#### first install the prerequisite, zeromq:
~~~
wget http://download.zeromq.org/zeromq-4.0.4.tar.gz
tar xf zeromq-4.0.4.tar.gz
cd zeromq-4.0.4
./configure
make && sudo make install
~~~

#### install zeromq c++ header, now separate.
~~~
git clone https://github.com/zeromq/cppzmq
# backup, vendored location: git clone https://github.com/mailgun/cppzmq
cd cppzmq/
sudo cp -p zmq.hpp /usr/local/include/
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


## An Opinionated Editorial. 

#### Or: in my humble opinion, why Pebblez is the best choice of transport.

What I like about protobuf over zeromq is that it is SO DARN UNIVERSAL.

Sure the next generation tech (capnproto over nanomsg) will be more scalable and has more features (see my [gozbus repo](https://github.com/glycerine/gozbus) for example), but the language support (e.g. in gogoprotobuf) is freaking amazing. 

*AND* this is the biggie: It works in R (yeeeeesssss!!), as the pebblezgo demonstrates.

And it is not just for R, because *everybody* and their dog has a pebblez transport available! (Again Pebblez is my name for ProtoBuf speaking Zeromq).

If you are looking for language support:

The starting list of zeromq bindings: http://zeromq.org/bindings:_start

The starting list of protobuf bindings: https://github.com/google/protobuf/wiki/Third-Party-Add-ons

but specifically:

golang (demonstrated in pebblezgo)

luajit ( https://github.com/Neopallium/lua-zmq  +  https://github.com/Neopallium/lua-pb )

python (pip install pyzmq / protocol buffer support shipped from google in the protobuf package)

java (yes)

c++ (yes)

php (the universe should forbid anyone ever use php, but yes)

javascript (on node, yes. on browser, can be gatewayed: github.com/dcodeIO/ProtoBuf.js + http://stackoverflow.com/questions/8145060/zeromq-in-javascript-client )

ruby (somebody wrote a gateway; http://avalanche123.com/blog/2012/02/25/interacting-with-zeromq-from-the-browser/  and https://github.com/progrium/nullmq/tree/master/demos/presence )


Hence: No need for crappy/impossible to maintain/impossible to refactor dynamic typing ever again. Type strong schema for everyone!  Plus evolve-able protocols (add/depricate fields over time).


Jason

p.s. Plus there is a security wrapper available too, http://curvezmq.org/. SWEET!!
