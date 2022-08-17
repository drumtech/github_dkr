FROM golang:1.16.5-alpine as build
ENV GO111MODULE auto
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN apk update && apk add git
RUN go get "github.com/caarlos0/env";\
    go get "github.com/prometheus/client_golang/prometheus";\
    go get "github.com/prometheus/client_golang/prometheus/promhttp";\
    go get "github.com/lib/pq";\
    go build main.go

FROM alpine:3.10.3
COPY --from=build /app/main .
CMD ["./main"]
