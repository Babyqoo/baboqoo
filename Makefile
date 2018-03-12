# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: gbbq android ios gbbq-cross swarm evm all test clean
.PHONY: gbbq-linux gbbq-linux-386 gbbq-linux-amd64 gbbq-linux-mips64 gbbq-linux-mips64le
.PHONY: gbbq-linux-arm gbbq-linux-arm-5 gbbq-linux-arm-6 gbbq-linux-arm-7 gbbq-linux-arm64
.PHONY: gbbq-darwin gbbq-darwin-386 gbbq-darwin-amd64
.PHONY: gbbq-windows gbbq-windows-386 gbbq-windows-amd64

GOBIN = $(shell pwd)/build/bin
GO ?= latest

gbbq:
	build/env.sh go run build/ci.go install ./cmd/gbbq
	@echo "Done building."
	@echo "Run \"$(GOBIN)/gbbq\" to launch gbbq."

swarm:
	build/env.sh go run build/ci.go install ./cmd/swarm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/swarm\" to launch swarm."

all:
	build/env.sh go run build/ci.go install

android:
	build/env.sh go run build/ci.go aar --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/gbbq.aar\" to use the library."

ios:
	build/env.sh go run build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/Geth.framework\" to use the library."

test: all
	build/env.sh go run build/ci.go test

clean:
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go get -u golang.org/x/tools/cmd/stringer
	env GOBIN= go get -u github.com/kevinburke/go-bindata/go-bindata
	env GOBIN= go get -u github.com/fjl/gencodec
	env GOBIN= go get -u github.com/golang/protobuf/protoc-gen-go
	env GOBIN= go install ./cmd/abigen
	@type "npm" 2> /dev/null || echo 'Please install node.js and npm'
	@type "solc" 2> /dev/null || echo 'Please install solc'
	@type "protoc" 2> /dev/null || echo 'Please install protoc'

# Cross Compilation Targets (xgo)

gbbq-cross: gbbq-linux gbbq-darwin gbbq-windows gbbq-android gbbq-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-*

gbbq-linux: gbbq-linux-386 gbbq-linux-amd64 gbbq-linux-arm gbbq-linux-mips64 gbbq-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-linux-*

gbbq-linux-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/gbbq
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-linux-* | grep 386

gbbq-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/gbbq
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-linux-* | grep amd64

gbbq-linux-arm: gbbq-linux-arm-5 gbbq-linux-arm-6 gbbq-linux-arm-7 gbbq-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-linux-* | grep arm

gbbq-linux-arm-5:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-5 -v ./cmd/gbbq
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-linux-* | grep arm-5

gbbq-linux-arm-6:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-6 -v ./cmd/gbbq
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-linux-* | grep arm-6

gbbq-linux-arm-7:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-7 -v ./cmd/gbbq
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-linux-* | grep arm-7

gbbq-linux-arm64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm64 -v ./cmd/gbbq
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-linux-* | grep arm64

gbbq-linux-mips:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/gbbq
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-linux-* | grep mips

gbbq-linux-mipsle:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/gbbq
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-linux-* | grep mipsle

gbbq-linux-mips64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/gbbq
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-linux-* | grep mips64

gbbq-linux-mips64le:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/gbbq
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-linux-* | grep mips64le

gbbq-darwin: gbbq-darwin-386 gbbq-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-darwin-*

gbbq-darwin-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/gbbq
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-darwin-* | grep 386

gbbq-darwin-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/gbbq
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-darwin-* | grep amd64

gbbq-windows: gbbq-windows-386 gbbq-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-windows-*

gbbq-windows-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/gbbq
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-windows-* | grep 386

gbbq-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/gbbq
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gbbq-windows-* | grep amd64
