package main

import (
	"bytes"
	"fmt"
	"os"
	"strconv"
)

type barInfo struct {
	Repeat  string
	N       int
	Message string
}

func parseArgs(args []string) *barInfo {
	cmdName := args[0]
	if len(args) < 3 {
		panic(fmt.Errorf("usage: %s <repeat> <n>", cmdName))
	}

	bar := &barInfo{}

	// repeat, n
	bar.Repeat = args[1]
	n, err := strconv.Atoi(args[2])
	if err != nil {
		panic(err)
	}
	bar.N = n

	// message
	if len(args) == 4 {
		bar.Message = args[3]
	}

	return bar
}

func makeBar(bar *barInfo) string {
	bytes := bytes.Repeat([]byte(bar.Repeat), bar.N)
	if len(bar.Message) == 0 {
		return string(bytes)
	}
	strLen := len(bytes)
	message := fmt.Sprintf(" %s ", bar.Message)
	messageLen := len(message)
	i := (strLen - messageLen) / 2
	copy(bytes[i:i+messageLen], message)
	return string(bytes)
}

func main() {
	barInfo := parseArgs(os.Args)
	bar := makeBar(barInfo)
	fmt.Println(bar)
}
