.PHONY: build cluster test

default: build

build:
	go build -o bin/swarm    github.com/baboqoo/go-baboqoo/cmd/swarm
	go build -o bin/gbbq     github.com/baboqoo/go-baboqoo/cmd/gbbq
	go build -o bin/bootnode github.com/baboqoo/go-baboqoo/cmd/bootnode

cluster: build
	scripts/boot-cluster.sh

test:
	go test -v github.com/baboqoo/go-baboqoo/swarm/...
