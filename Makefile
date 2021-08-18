# these will speed up builds, for docker-compose >= 1.25
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1

all: build push

build:
	docker-compose build 'r-package'

push:
    docker-compose push 'r-package'
