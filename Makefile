.PHONY: help
SHELL         := /bin/bash
MAKEFILE_PATH := ./Makefile
MAKEFILES_DIR := ./@bin/makefiles
MAKEFILES_VER := v0.1.38

define DOCKER_IMG_LIST
"ansible" \
"ansible-dev" \
"git-release" \
"leverage-cli-testing" \
"terraform-awscli-slim" \
"terraform-awscli-terratest-slim" \
"helmsman"
endef

help:
	@echo 'Available Commands:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf " - \033[36m%-18s\033[0m %s\n", $$1, $$2}'

#==============================================================#
# INITIALIZATION                                               #
#==============================================================#
init-makefiles: ## initialize makefiles
	rm -rf ${MAKEFILES_DIR}
	mkdir -p ${MAKEFILES_DIR}
	git clone https://github.com/binbashar/le-dev-makefiles.git ${MAKEFILES_DIR} -q
	cd ${MAKEFILES_DIR} && git checkout ${MAKEFILES_VER} -q

-include ${MAKEFILES_DIR}/circleci/circleci.mk
-include ${MAKEFILES_DIR}/release-mgmt/release.mk

#==============================================================#
# DOCKER | BUILD ALL IMAGES                                    #
#==============================================================#
build-all: ## build all docker images
	LIST=(${DOCKER_IMG_LIST});\
    OLDIFS=$$IFS;\
    IFS=',';\
    for i in "$${LIST[@]}"; do\
		set -- $$i;\
        echo -----------------------;\
        echo DOCKER IMG: $$1;\
        echo -----------------------;\
				cd $$1;\
				make build;\
				cd ..;\
        echo -----------------------;\
        echo "DOCKER BUILD DONE";\
        echo "";\
	done;\
	IFS=$$OLDIFS

#==============================================================#
# DOCKER | TEST ALL IMAGES                                     #
#==============================================================#
test-all: ## build all docker images
	LIST=(${DOCKER_IMG_LIST});\
    OLDIFS=$$IFS;\
    IFS=',';\
    for i in "$${LIST[@]}"; do\
		set -- $$i;\
        echo -----------------------;\
        echo DOCKER IMG: $$1;\
        echo -----------------------;\
				cd $$1;\
				make test;\
				cd ..;\
        echo -----------------------;\
        echo "DOCKER TEST DONE";\
        echo "";\
	done;\
	IFS=$$OLDIFS

#==============================================================#
# DOCKER | PUSH ALL IMAGES                                     #
#==============================================================#
push-all: ## build all docker images
	LIST=(${DOCKER_IMG_LIST});\
    OLDIFS=$$IFS;\
    IFS=',';\
    for i in "$${LIST[@]}"; do\
		set -- $$i;\
        echo -----------------------;\
        echo DOCKER IMG: $$1;\
        echo -----------------------;\
				cd $$1;\
				make push;\
				cd ..;\
        echo -----------------------;\
        echo "DOCKER PUSH DONE";\
        echo "";\
	done;\
	IFS=$$OLDIFS
