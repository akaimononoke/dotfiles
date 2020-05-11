package main

import (
	"fmt"
	"os"
	"os/exec"
	"strconv"
	"time"
)

func getNotifyText(cumulativeDuration time.Duration, unit time.Duration) string {
	var unitStr string
	switch unit {
	case time.Second:
		unitStr = "seconds"
	case time.Minute:
		unitStr = "minutes"
	case time.Hour:
		unitStr = "hours"
	}
	return fmt.Sprintf("%d %s have elapsed", cumulativeDuration, unitStr)
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

	exec.Command("terminal-notifier", "-message", "Started continuous timer", "-sound", "Bosso").Run()

	var cumulativeDuration time.Duration

	for {
		time.Sleep(interval * unit)
		cumulativeDuration += interval
		exec.Command("terminal-notifier", "-message", getNotifyText(cumulativeDuration / interval, unit), "-sound", "Glass").Run()
	}
}
