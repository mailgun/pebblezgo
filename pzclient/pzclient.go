package main

import (
	"fmt"

	"github.com/vaughan0/go-zmq"
)

var addr string = "tcp://127.0.0.1:5556"

func main() {

	// Create a new ZeroMQ Context and Socket:
	ctx, err := zmq.NewContext()
	if err != nil {
		panic(err)
	}
	defer ctx.Close()

	// Bind to a local endpoint:
	sock, err := ctx.Socket(zmq.Req)
	if err != nil {
		panic(err)
	}
	defer sock.Close()

	if err = sock.Connect(addr); err != nil {
		panic(err)
	}

	fmt.Printf("client: connected to address '%s'\n", addr)

	// send and receive
	reqcount := 0
	for {

		request := fmt.Sprintf("hello %d from client", reqcount)
		reqcount++

		// requester.SendPart([]byte("Hello"), false)
		// or
		err = sock.Send([][]byte{
			[]byte(request),
		})
		if err != nil {
			panic(err)
		}
		fmt.Printf("client sent '%#v'\n", request)

		// reply, _, _ := requester.RecvPart()
		parts, err := sock.Recv()
		if err != nil {
			panic(err)
		}
		partcount := 0
		for i := range parts {
			fmt.Printf("client received part %d = '%v'\n", partcount, string(parts[i]))
			partcount++
		}
	}

}
