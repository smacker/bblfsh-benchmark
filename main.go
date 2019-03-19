package main

import (
	"bufio"
	"bytes"
	"encoding/json"
	"flag"
	"fmt"
	"io"
	"io/ioutil"
	"math"
	"os/exec"
	"strconv"
	"sync"
	"time"

	bblfsh "gopkg.in/bblfsh/client-go.v3"
)

var path = flag.String("path", "", "path to file")
var language = flag.String("language", "", "")
var times = flag.Int("times", 500, "number of parses")
var parallel = flag.Int("parallel", 0, "")
var port = flag.Int("port", 0, "")
var native = flag.String("native", "", "name of container to test native driver")

func main() {
	flag.Parse()

	if *native != "" {
		nativeTest(*native)
		return
	}

	grpc()
}

func grpc() {
	if *language == "" {
		panic("no language")
	}

	if *port == 0 {
		*port = 9432
	}

	c := NewClient(*port)
	if *parallel > 0 {
		fmt.Println(c.Parallel(*path, *language, *times, *parallel))
		return
	}
	fmt.Println(c.Consequentially(*path, *language, *times))
}

func nativeTest(container string) {
	b, err := ioutil.ReadFile(*path)
	if err != nil {
		panic(err)
	}
	b, err = json.Marshal(struct {
		Content string `json:"content"`
	}{string(b)})
	if err != nil {
		panic(err)
	}

	cmd := exec.Command("docker", "exec", "-i", container, "/opt/driver/bin/native")

	stdin, err := cmd.StdinPipe()
	if err != nil {
		panic(err)
	}
	stdout, err := cmd.StdoutPipe()
	if err != nil {
		panic(err)
	}
	cmd.Start()

	reader := bufio.NewReader(stdout)

	// warm up
	go func() {
		io.Copy(stdin, bytes.NewReader(b))
		io.WriteString(stdin, "\n")
	}()
	_, err = reader.ReadString('\n')
	if err != nil {
		panic(err)
	}

	st := time.Now()
	go func() {
		defer stdin.Close()
		for i := 0; i < *times; i++ {
			io.Copy(stdin, bytes.NewReader(b))
			io.WriteString(stdin, "\n")
		}
	}()

	for {
		_, err := reader.ReadString('\n')
		if err == io.EOF {
			break
		}
		if err != nil {
			panic(err)
		}
	}
	fmt.Println(time.Now().Sub(st))
}

type Client struct {
	client *bblfsh.Client
}

func NewClient(port int) *Client {
	client, err := bblfsh.NewClient("0.0.0.0:" + strconv.Itoa(port))
	if err != nil {
		panic(err)
	}

	return &Client{client: client}
}

func (c *Client) Consequentially(path, language string, times int) time.Duration {
	content := c.getContent(path)

	st := time.Now()

	for i := 0; i < times; i++ {
		_, _, err := c.client.NewParseRequest().Language(language).Mode(bblfsh.Native).Content(content).UAST()

		if err != nil {
			panic(err)
		}
	}

	return time.Now().Sub(st)
}

func (c *Client) Parallel(path, language string, times, parallel int) time.Duration {
	content := c.getContent(path)

	times = int(math.Ceil(float64(times) / float64(parallel)))
	var wg sync.WaitGroup

	st := time.Now()

	for p := 0; p < parallel; p++ {
		wg.Add(1)
		go func() {
			for i := 0; i < times; i++ {
				_, _, err := c.client.NewParseRequest().Language(language).Mode(bblfsh.Native).Content(content).UAST()
				if err != nil {
					panic(err)
				}
			}
			wg.Done()
		}()
	}
	wg.Wait()

	return time.Now().Sub(st)
}

func (c *Client) getContent(path string) string {
	b, err := ioutil.ReadFile(path)
	if err != nil {
		panic(err)
	}
	return string(b)
}
