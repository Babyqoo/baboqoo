# Build Gbbq in a stock Go builder container
FROM golang:1.9-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers

ADD . /baboqoo
RUN cd /baboqoo && make geth

# Pull Gbbq into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /baboqoo/build/bin/geth /usr/local/bin/

EXPOSE 8545 8546 30303 30303/udp 30304/udp
ENTRYPOINT ["geth"]
