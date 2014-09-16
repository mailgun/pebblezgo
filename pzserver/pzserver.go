package main

import (
	"fmt"
	"time"

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
	sock, err := ctx.Socket(zmq.Rep)
	if err != nil {
		panic(err)
	}
	defer sock.Close()

	if err = sock.Bind(addr); err != nil {
		panic(err)
	}
	fmt.Printf("server: bound address '%s'\n", addr)

	// receive and send
	count := 0
	for {
		parts, err := sock.Recv()
		// request, _, _ := responder.RecvPart()
		if err != nil {
			panic(err)
		}
		fmt.Printf("server received %d parts; parts[0]: '%s'\n", len(parts), string(parts[0]))

		// delay to not run off screen
		time.Sleep(1 * time.Second)

		response := fmt.Sprintf("server response #%d", count)
		count++
		err = sock.Send([][]byte{
			[]byte(response),
		})
		if err != nil {
			panic(err)
		}
		fmt.Printf("server sent response: '%s'\n", response)
	}

}
