.PHONY: build cluster test

default: build

build:
	go build -o bin/swarm    github.com/babyqoo/baboqoo/cmd/swarm
	go build -o bin/gbbq     github.com/babyqoo/baboqoo/cmd/gbbq
	go build -o bin/bootnode github.com/babyqoo/baboqoo/cmd/bootnode

cluster: build
	scripts/boot-cluster.sh

test:
	go test -v github.com/babyqoo/baboqoo/swarm/...
