.PHONY: build
SHELL            := /bin/bash
MAKEFILES_DIR    := ../@bin/makefiles

DOCKER_ORG 		:= binbash
DOCKER_IMAGE 	:= helmsman
DOCKER_TAG 		:= v3.4.3-helm-v3.2.1

BASE_HELMSMAN_IMAGE	:= praqma/helmsman:v3.4.3-helm-v3.2.1


help:
	@echo 'Available Commands:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf " - \033[36m%-18s\033[0m %s\n", $$1, $$2}'

-include ${MAKEFILES_DIR}/docker/docker-hub-build-push-single-arg.mk

build: ## Build main image
	docker build -t ${DOCKER_ORG}/${DOCKER_IMAGE}:${DOCKER_TAG} \
		--build-arg BASE_HELMSMAN_IMAGE=${BASE_HELMSMAN_IMAGE} \
		--target main \
		.

#
# docker run tests
#
get-all-versions: ## Get helmsman, helm and aws-iam-authenticator version
	docker run -it --rm \
		${DOCKER_ORG}/${DOCKER_IMAGE}:${DOCKER_TAG} -v
	docker run -it --rm \
		--entrypoint helm \
		${DOCKER_ORG}/${DOCKER_IMAGE}:${DOCKER_TAG} version
	docker run -it --rm \
		--entrypoint aws-iam-authenticator \
		${DOCKER_ORG}/${DOCKER_IMAGE}:${DOCKER_TAG} version

test: get-all-versions ## ci docker image tests

