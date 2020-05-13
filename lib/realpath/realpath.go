package main

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
)

func parseArgs(args []string) []string {
	// from pipeline
	fileInfo, err := os.Stdin.Stat()
	if err != nil {
		panic(err)
	}
	if fileInfo.Mode()&os.ModeNamedPipe != 0 {
		defer os.Stdin.Close()

		var paths []string
		scanner := bufio.NewScanner(os.Stdin)
		for scanner.Scan() {
			paths = append(paths, scanner.Text())
		}
		return paths
	}

	// from command line args
	if len(os.Args) < 2 {
		pwd, err := os.Getwd()
		if err != nil {
			panic(err)
		}
		return []string{pwd}
	}
	return os.Args[1:]
}

func getRealpath(path string) string {
	absPath, err := filepath.Abs(path)
	if err != nil {
		panic(err)
	}
	return absPath
}

func main() {
	paths := parseArgs(os.Args)
	for _, p := range paths {
		fmt.Println(getRealpath(p))
	}
}
