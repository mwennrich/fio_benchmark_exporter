FROM golang:1.26-alpine AS build

ENV GO111MODULE=on
ENV CGO_ENABLED=0

RUN apk add make binutils git

COPY . /app
WORKDIR /app


RUN go build -o fio_benchmark_exporter
RUN strip fio_benchmark_exporter

FROM alpine:3.23

RUN apk add fio

WORKDIR /
USER 65534:65534

COPY --from=build /app/fio_benchmark_exporter .

EXPOSE 9996

ENTRYPOINT [ "./fio_benchmark_exporter" ]
