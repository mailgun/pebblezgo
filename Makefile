all:
	cd pzclient; go build pzclient.go
	cd pzserver; go build pzserver.go
	./pzserver/pzserver &
	./pzclient/pzclient

clean:
	rm -f ./pzserver/pzserver
	rm -f ./pzclient/pzclient
	rm -f *~
