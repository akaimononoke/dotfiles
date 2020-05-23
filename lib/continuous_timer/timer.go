package main

import (
	"fmt"
	"os"
	"os/exec"
	"strconv"
	"time"
)

const (
	cmdName  = "Continuous Timer"
)

func timeunitToString(unit time.Duration) string {
	switch unit {
	case time.Second:
		return "seconds"
	case time.Minute:
		return "minutes"
	case time.Hour:
		return "hours"
	}
	return ""
}

func terminalNotifier(message, sound string) *exec.Cmd {
	args := []string{
		"-title", cmdName,
		"-message", message,
		"-sound", sound,
	}
	return exec.Command("terminal-notifier", args...)
}

func main() {
	cmd, argc := os.Args[0], len(os.Args)

	if argc < 2 {
		fmt.Errorf("usage: %s <interval> <s[seconds]/m[minutes]/h[hours]>", cmd)
		return
	}

	intervalInt, err := strconv.Atoi(os.Args[1])
	if err != nil {
		fmt.Errorf("interval should be an interger: %v", intervalInt)
		return
	}
	interval := time.Duration(intervalInt)

	unitStr := os.Args[2]
	var unit time.Duration
	switch unitStr {
	case "s", "seconds":
		unit = time.Second
	case "m", "minutes":
		unit = time.Minute
	case "h", "hours":
		unit = time.Hour
	default:
		fmt.Errorf("interval unit should be either s[seconds], m[minutes], h[hours]: %v", unitStr)
	}

	terminalNotifier(fmt.Sprintf("You will be notified every %d %s.", interval, timeunitToString(unit)), "Bosso").Run()

	var cumulativeDuration time.Duration

	for {
		time.Sleep(interval * unit)
		cumulativeDuration += interval
		terminalNotifier(fmt.Sprintf("%d %s have elapsed.", cumulativeDuration, timeunitToString(unit)), "Glass").Run()
	}
}
