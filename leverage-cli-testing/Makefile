.PHONY: help build
SHELL			 := /bin/bash
MAKEFILES_DIR	 := ../@bin/makefiles

DOCKER_TAG		 := 2.0.0
DOCKER_REPO_NAME := binbash
DOCKER_IMG_NAME  := leverage-cli-testing

help:
	@echo 'Available Commands:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf " - \033[36m%-18s\033[0m %s\n", $$1, $$2}'

-include ${MAKEFILES_DIR}/docker/docker-hub-build-push.mk
