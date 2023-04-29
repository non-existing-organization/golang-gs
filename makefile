OUTPUT_DIR = ./bin

all:
	echo "Building for all platforms"
	GOOS=linux GOARCH=amd64 go build -o $(OUTPUT_DIR)/gsls_linux_amd64 gsls.go
	GOOS=darwin GOARCH=amd64 go build -o $(OUTPUT_DIR)/gsls_darwin_amd64 gsls.go
	GOOS=windows GOARCH=amd64 go build -o $(OUTPUT_DIR)/gsls_windows_amd64.exe gsls.go
	GOOS=linux GOARCH=arm go build -o $(OUTPUT_DIR)/gsls_linux_arm gsls.go
	GOOS=linux GOARCH=arm64 go build -o $(OUTPUT_DIR)/gsls_linux_arm64 gsls.go
	GOOS=windows GOARCH=386 go build -o $(OUTPUT_DIR)/gsls_windows_386.exe gsls.go
	tar -czvf golang-gsls-0.1.1.tar.gz ./bin/*

clean:
	rm -f ./bin/*

.PHONY: all clean
