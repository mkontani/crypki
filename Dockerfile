FROM golang:1.13
ENV CRYPKI_DIR /go/src/github.com/yahoo/crypki
COPY . ${CRYPKI_DIR}
WORKDIR ${CRYPKI_DIR}
RUN go get -v ./... && go test ./... && go build -o crypki-bin ${CRYPKI_DIR}/cmd/crypki

FROM debian:sid-slim
ENV CRYPKI_DIR /go/src/github.com/yahoo/crypki

COPY --from=0 ${CRYPKI_DIR}/crypki-bin /usr/bin/

ENTRYPOINT ["crypki-bin"]
