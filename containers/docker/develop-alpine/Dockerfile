FROM alpine:3.7

RUN \
  apk add --update go git make gcc musl-dev linux-headers ca-certificates && \
  git clone --depth 1 https://github.com/baboqoo/go-baboqoo && \
  (cd go-baboqoo && make gbbq) && \
  cp go-baboqoo/build/bin/gbbq /gbbq && \
  apk del go git make gcc musl-dev linux-headers && \
  rm -rf /go-baboqoo && rm -rf /var/cache/apk/*

EXPOSE 8545
EXPOSE 30303

ENTRYPOINT ["/gbbq"]
