FROM alpine:3.7

RUN \
  apk add --update go git make gcc musl-dev linux-headers ca-certificates && \
  git clone --depth 1 https://github.com/baboqoo/baboqoo && \
  (cd baboqoo && make gbbq) && \
  cp baboqoo/build/bin/gbbq /gbbq && \
  apk del go git make gcc musl-dev linux-headers && \
  rm -rf /baboqoo && rm -rf /var/cache/apk/*

EXPOSE 8545
EXPOSE 30303

ENTRYPOINT ["/gbbq"]
