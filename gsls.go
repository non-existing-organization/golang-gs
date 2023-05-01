package main

import (
	"flag"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

var version = "0.2.0"

func main() {
	var dir string

	// Define the --version flag
	flagVersion := flag.Bool("version", false, "print the app version")
	flag.Parse()

	// Print the app version if the flag is set
	if *flagVersion {
		fmt.Println("gsls version", version)
		return
	}

	// Get the directory from the command-line arguments
	if len(os.Args) > 1 {
		dir = os.Args[1]
	} else {
		// Get the current directory
		var err error
		dir, err = os.Getwd()
		if err != nil {
			fmt.Println("Error getting current directory:", err)
			os.Exit(1)
		}
	}
	if len(os.Args) > 1 {
		dir = os.Args[1]
	} else {
		// Get the current directory
		var err error
		dir, err = os.Getwd()
		if err != nil {
			fmt.Println("Error getting current directory:", err)
			os.Exit(1)
		}
	}

	// Open the directory
	f, err := os.Open(dir)
	if err != nil {
		fmt.Println("Error opening directory:", err)
		os.Exit(1)
	}
	defer f.Close()

	// Read the contents of the directory
	files, err := f.Readdir(-1)
	if err != nil {
		fmt.Println("Error reading directory contents:", err)
		os.Exit(1)
	}

	// Find the length of the longest file name
	var maxNameLen int
	for _, file := range files {
		if len(file.Name()) > maxNameLen {
			maxNameLen = len(file.Name())
		}
	}

	// Print the header
	fmt.Printf("%-10s\t%-*s\t%-5s\t%-12s\t%s\n", "Mode", maxNameLen, "Name", "Size", "Date", "Git State")

	// Iterate over the contents of the directory
	for _, file := range files {
		// Get the file mode string
		mode := file.Mode().String()

		// Determine the color for each letter in the file mode
		coloredMode := ""
		for _, char := range mode {
			color := ""
			switch char {
			case 'd':
				color = "\033[1;34m"
			case '-':
				color = "\033[0;37m"
			case 'r':
				color = "\033[1;32m"
			case 'w':
				color = "\033[1;31m"
			case 'x':
				color = "\033[1;33m"
			}
			coloredMode += color + string(char) + "\033[0m"
		}

		// Get the git state if the file is a git repository
		gitState := ""
		if file.IsDir() {
			gitPath := filepath.Join(dir, file.Name(), ".git")
			_, err := os.Stat(gitPath)
			if !os.IsNotExist(err) {
				state, err := getGitState(filepath.Join(dir, file.Name()))
				if err != nil {
					fmt.Println(err)
					os.Exit(1)
				}
				gitState = state
			}
		}

		// Print the file information
		fmt.Printf("%-10s\t%-*s\t%-5d\t%-12s\t%s\n", coloredMode, maxNameLen, file.Name(), file.Size(), file.ModTime().Format("2006-01-02"), gitState)
	}
}

func getGitState(dir string) (string, error) {
	// Change to the git repository directory
	err := os.Chdir(dir)
	if err != nil {
		return "", fmt.Errorf("Error changing to git repository directory: %v", err)
	}

	// Run the `git status` command
	out, err := exec.Command("git", "status", "--porcelain").Output()
	if err != nil {
		return "", fmt.Errorf("Error running `git status` command: %v", err)
	}

	// Parse the output of the `git status` command
	output := string(out)
	lines := strings.Split(output, "\n")

	// Determine the state of the Git
	state := ""
	color := ""
	for _, line := range lines {
		if strings.HasPrefix(line, "##") {
			if strings.Contains(line, "behind") {
				state = "Branch is Behind Remote"
				color = "\033[31m" // red
				break
			} else if strings.Contains(line, "ahead") {
				state = "Branch is Ahead of Remote"
				color = "\033[32m" // green
				break
			} else {
				state = "Branch is Up-to-date with Remote"
				color = "\033[33m" // yellow
				break
			}
		} else if strings.HasPrefix(line, "??") {
			state = "Untracked Files"
			color = "\033[34m" // blue
			break
		} else if strings.HasPrefix(line, " M") {
			state = "Modified Files"
			color = "\033[35m" // purple
			break
		} else if strings.HasPrefix(line, "A ") {
			state = "Added Files"
			color = "\033[36m" // cyan
			break
		} else if strings.HasPrefix(line, "D ") {
			state = "Deleted Files"
			color = "\033[31m" // red
			break
		} else if strings.HasPrefix(line, "R ") {
			state = "Renamed Files"
			color = "\033[32m" // green
			break
		} else if strings.HasPrefix(line, "C ") {
			state = "Copied Files"
			color = "\033[33m" // yellow
			break
		} else if strings.HasPrefix(line, "U ") {
			state = "Unmerged Files"
			color = "\033[31m" // red
			break
		} else if len(line) > 0 {
			state = "Dirty"
			color = "\033[35m" // purple
			break
		}
	}

	return color + state + "\033[0m", nil
}
