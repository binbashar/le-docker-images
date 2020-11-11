.PHONY: build
SHELL            := /bin/bash
MAKEFILES_DIR    := ../@bin/makefiles

DOCKER_TAG       := 2.10.3
DOCKER_REPO_NAME := binbash
DOCKER_IMG_NAME  := ansible-dev

help:
	@echo 'Available Commands:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf " - \033[36m%-18s\033[0m %s\n", $$1, $$2}'

-include ${MAKEFILES_DIR}/docker/docker-hub-build-push-single-arg.mk

shell: ## interactive shell terminal
	docker run -it --rm --entrypoint=bash \
	${DOCKER_REPO_NAME}/${DOCKER_IMG_NAME}:${DOCKER_TAG}

#
# docker run tests
#
run-python-version: ## docker run python --version
	docker run -it --rm --entrypoint=python \
	${DOCKER_REPO_NAME}/${DOCKER_IMG_NAME}:${DOCKER_TAG} --version

run-ansible-version: ## docker run ansible --version
	docker run -it --rm \
	${DOCKER_REPO_NAME}/${DOCKER_IMG_NAME}:${DOCKER_TAG} --version

run-molecule-version: ## docker run molecule --version
	docker run -it --rm --entrypoint=molecule \
	${DOCKER_REPO_NAME}/${DOCKER_IMG_NAME}:${DOCKER_TAG} --version

run-yamllint-version: ## docker run yamllint --version
	docker run -it --rm --entrypoint=yamllint \
	${DOCKER_REPO_NAME}/${DOCKER_IMG_NAME}:${DOCKER_TAG} --version

run-ansible-lint-version: ## docker run ansible-lint --version
	docker run -it --rm --entrypoint=ansible-lint \
	${DOCKER_REPO_NAME}/${DOCKER_IMG_NAME}:${DOCKER_TAG} --version

run-all: run-python-version run-ansible-version run-molecule-version run-yamllint-version run-ansible-lint-version

test: run-all ## ci docker image tests
