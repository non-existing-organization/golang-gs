OUTPUT_DIR = ./bin

all:
	echo "Building for all platforms"
	GOOS=linux GOARCH=amd64 go build -o $(OUTPUT_DIR)/gs_linux_amd64 gs.go
	GOOS=darwin GOARCH=amd64 go build -o $(OUTPUT_DIR)/gs_darwin_amd64 gs.go
	GOOS=windows GOARCH=amd64 go build -o $(OUTPUT_DIR)/gs_windows_amd64.exe gs.go
	GOOS=linux GOARCH=arm go build -o $(OUTPUT_DIR)/gs_linux_arm gs.go
	GOOS=linux GOARCH=arm64 go build -o $(OUTPUT_DIR)/gs_linux_arm64 gs.go
	GOOS=windows GOARCH=386 go build -o $(OUTPUT_DIR)/gs_windows_386.exe gs.go
clean:
	rm -f ./bin/*

.PHONY: all clean
