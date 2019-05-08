FROM golang:1.12 as builder
ADD . /go/src/github.com/lfurrea/lolcat
WORKDIR /go/src/github.com/lfurrea/lolcat
ENV TARGET=linux ARCH=amd64
RUN make build

FROM alpine:3.8 as resource
COPY --from=builder /go/src/github.com/lfurrea/build/lolcat /usr/local/bin
RUN apk add --update --no-cache \
    git \
    openssh \
    jq \
    && chmod +x /usr/local/bin/*

FROM resource
LABEL MAINTAINER=lfurrea
CMD ["lolcat"]
