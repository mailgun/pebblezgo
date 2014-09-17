package main

import (
	"fmt"
	"time"

	code_google_com_p_gogoprotobuf_proto "code.google.com/p/gogoprotobuf/proto"
	"github.com/mailgun/pebblezgo/events"
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

		fmt.Printf("server received %d parts\n", len(parts))

		if len(parts) != 1 {
			panic("only expecting parts to be of length 1")
		}
		ep := &events.EventPrime{}
		if err := code_google_com_p_gogoprotobuf_proto.Unmarshal(parts[0], ep); err != nil {
			panic(err)
		}
		fmt.Printf("server received into EventPrime: %#v\n", ep)

		// delay to not run off screen
		time.Sleep(1 * time.Second)

		//response := fmt.Sprintf("server response #%d", count)

		// create an event.EventPrime to send back
		//popr := math_rand.New(math_rand.NewSource(time.Now().UnixNano()))
		//ev := events.NewPopulatedEventPrime(popr, false)

		ev := &events.EventPrime{
			Db:     54.4,
			Count:  int64(count),
			Str:    "Hello Events!",
			By:     []byte{1, 2, 3},
			StrVec: []string{"abc", "def"},
			DbVec:  []float64{.5, 2.5, 10.105},
		}

		response, err := code_google_com_p_gogoprotobuf_proto.Marshal(ev)
		if err != nil {
			panic(err)
		}

		count++
		err = sock.Send([][]byte{
			[]byte(response),
		})
		if err != nil {
			panic(err)
		}
		fmt.Printf("server created and sent response event ev = %#v\n\n", ev)
	}

}
