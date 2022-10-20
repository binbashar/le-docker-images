.PHONY: help
SHELL            := /bin/bash
KANIKO_VERSION   := "1.9.0"
DOCKER_TAG       := ${KANIKO_VERSION}
DOCKER_REPO_NAME := binbash
DOCKER_IMG_NAME  := kaniko
MAKEFILES_DIR    := ../@bin/makefiles
TARGET_PLATFORMS := 'linux/amd64'
ADDITIONAL_TAGS  := "latest"
ADDITIONAL_DOCKER_ARGS := "KANIKO_VERSION='${KANIKO_VERSION}'"

-include ${MAKEFILES_DIR}/docker/docker-hub-build-push-single-arg-multi-arch.mk

help:
	@echo 'Available Commands:'
	@egrep '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":"}; { if ($$3 == "") { printf " - \033[36m%-18s\033[0m %s\n", $$1, $$2 } else { printf " - \033[36m%-18s\033[0m %s\n", $$2, $$3 }}'

