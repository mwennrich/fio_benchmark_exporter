GO111MODULE := on
DOCKER_TAG := $(or ${GIT_TAG_NAME}, latest)

all: fio_benchmark_exporter

.PHONY: fio_benchmark_exporter
fio_benchmark_exporter:
	go build -o bin/fio_benchmark_exporter
	strip bin/fio_benchmark_exporter

.PHONY: dockerimages
dockerimages:
	docker build -t mwennrich/fio_benchmark_exporter:${DOCKER_TAG} .

.PHONY: dockerpush
dockerpush:
	docker push mwennrich/fio_benchmark_exporter:${DOCKER_TAG}

.PHONY: clean
clean:
	rm -f bin/*
