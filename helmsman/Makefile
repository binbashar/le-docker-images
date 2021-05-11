.PHONY: build
SHELL            := /bin/bash
MAKEFILES_DIR    := ../@bin/makefiles

DOCKER_ORG 		:= binbash
DOCKER_IMG_NAME := helmsman
DOCKER_TAG 		:= v3.6.8-helm-v3.4.2
BASE_HELMSMAN_IMAGE	:= praqma/helmsman:${DOCKER_TAG}


help:
	@echo 'Available Commands:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf " - \033[36m%-18s\033[0m %s\n", $$1, $$2}'

-include ${MAKEFILES_DIR}/docker/docker-hub-build-push-single-arg.mk

build: ## Build main image
	docker build -t ${DOCKER_ORG}/${DOCKER_IMG_NAME}:${DOCKER_TAG} \
		--build-arg BASE_HELMSMAN_IMAGE=${BASE_HELMSMAN_IMAGE} \
		--target main \
		.

#
# docker run tests
#
get-all-versions: ## Get helmsman, helm and aws-iam-authenticator version
	docker run -it --rm \
		${DOCKER_ORG}/${DOCKER_IMG_NAME}:${DOCKER_TAG} -v
	docker run -it --rm \
		--entrypoint helm \
		${DOCKER_ORG}/${DOCKER_IMG_NAME}:${DOCKER_TAG} version
	docker run -it --rm \
		--entrypoint aws-iam-authenticator \
		${DOCKER_ORG}/${DOCKER_IMG_NAME}:${DOCKER_TAG} version
	docker run -it --rm \
		--entrypoint eyaml \
		${DOCKER_ORG}/${DOCKER_IMG_NAME}:${DOCKER_TAG} version

test: get-all-versions ## ci docker image tests

