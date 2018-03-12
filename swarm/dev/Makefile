.PHONY: build cluster test

default: build

build:
	go build -o bin/swarm    github.com/baboqoo/baboqoo/cmd/swarm
	go build -o bin/gbbq     github.com/baboqoo/baboqoo/cmd/gbbq
	go build -o bin/bootnode github.com/baboqoo/baboqoo/cmd/bootnode

cluster: build
	scripts/boot-cluster.sh

test:
	go test -v github.com/baboqoo/baboqoo/swarm/...
