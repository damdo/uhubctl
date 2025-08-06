package main

import (
	"fmt"
	"os"
	"os/exec"
	"syscall"
)

func main() {
	if os.Getenv("GOKRAZY_FIRST_START") == "1" {
		os.Exit(0)
	}
	const frozenDir = "/usr/lib/aarch64-linux-gnu/uhubctl.frozen"
	uhubctl := exec.Command(
		frozenDir+"/ld-linux-aarch64.so.1",
		append([]string{
			frozenDir + "/uhubctl",
		}, os.Args[1:]...)...)
	uhubctl.Env = append(os.Environ(), "LD_LIBRARY_PATH="+frozenDir)
	uhubctl.Stdin = os.Stdin
	uhubctl.Stdout = os.Stdout
	uhubctl.Stderr = os.Stderr
	err := uhubctl.Run()
	if err != nil {
		if exiterr, ok := err.(*exec.ExitError); ok {
			if status, ok := exiterr.Sys().(syscall.WaitStatus); ok {
				os.Exit(status.ExitStatus())
			}
		} else {
			fmt.Fprintf(os.Stderr, "%v: %v\n", uhubctl.Args, err)
		}
	}
}
