
regenerate:
	(protoc --proto_path=../:protobuf/:. --gogo_out=. *.proto)
	go build; go install
