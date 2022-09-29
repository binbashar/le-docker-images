.PHONY: help
SHELL            := /bin/bash
DOCKER_REPO_NAME := kaniko

help:
	@echo 'Available Commands:'
	@egrep '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":"}; { if ($$3 == "") { printf " - \033[36m%-18s\033[0m %s\n", $$1, $$2 } else { printf " - \033[36m%-18s\033[0m %s\n", $$2, $$3 }}'

#==============================================================#
# DOCKER                                                       #
#==============================================================#
build: ## build docker image
	docker build -t public.ecr.aws/n0c8p2u1/kaniko:latest --build-arg KANIKO_VERSION='1.9.0' .
