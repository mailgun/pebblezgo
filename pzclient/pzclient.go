package main

import (
	"fmt"

	"encoding/json"

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
	replycount := 0
	for {

		request := &events.EventPrime{
			Db:     222.9,
			Count:  int64(reqcount),
			Str:    "originated by pzclient.go",
			By:     []byte{9},
			StrVec: []string{"yowzah"},
			DbVec:  []float64{7.7, 5.5},
		}

		reqBytes, err := code_google_com_p_gogoprotobuf_proto.Marshal(request)
		if err != nil {
			panic(err)
		}

		reqcount++

		// requester.SendPart([]byte(reqBytes), false)
		// or
		err = sock.Send([][]byte{
			[]byte(reqBytes),
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
		for i := range parts {

			msg := &events.EventPrime{}
			if err := code_google_com_p_gogoprotobuf_proto.Unmarshal(parts[i], msg); err != nil {
				panic(err)
			}
			fmt.Printf("client received reply %d, into EventPrime: %#v\n", replycount, msg)
			replycount++

			j, err := json.Marshal(msg)
			if err != nil {
				panic(err)
			}
			fmt.Printf("client printing as json: '%s'\n\n", string(j))
		}
	}

}
