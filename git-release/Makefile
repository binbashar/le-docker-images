.PHONY: build
SHELL            := /bin/bash
MAKEFILES_DIR    := ../@bin/makefiles

DOCKER_TAG       := 0.0.3
DOCKER_REPO_NAME := binbash
DOCKER_IMG_NAME  := git-release

DOCKER_PWD_DIR    := $(shell pwd)
DOCKER_SEMTAG_CMD := /opt/semtag/semtag/semtag

help:
	@echo 'Available Commands:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf " - \033[36m%-18s\033[0m %s\n", $$1, $$2}'

-include ${MAKEFILES_DIR}/docker/docker-hub-build-push.mk

run-git-chglog: ## docker run git-chglog
	docker run -it --rm -v "${DOCKER_PWD_DIR}:/data" ${DOCKER_REPO_NAME}/git-release --version

run-git-semtag: ## docker run semtag
	docker run -it --rm -v "${DOCKER_PWD_DIR}:/data" --entrypoint=${DOCKER_SEMTAG_CMD} ${DOCKER_REPO_NAME}/git-release --version

test: run-git-chglog run-git-semtag ## ci docker image tests
