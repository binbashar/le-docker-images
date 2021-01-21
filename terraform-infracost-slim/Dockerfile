ARG DOCKER_TAG
ARG TERRAFORM_VERSION=${DOCKER_TAG}

FROM hashicorp/terraform:${TERRAFORM_VERSION}

LABEL vendor="Binbash Leverage (info@binbash.com.ar)"

ARG INFRACOST_VERSION="v0.7.14"

# Install python3 and other useful dependencies
RUN apk update
RUN set -ex && \
        apk add ca-certificates && update-ca-certificates && \
	apk add --no-cache --update \
        curl \
        unzip \
        bash \
        make \
        tree \
        tzdata \
        jq \
        oath-toolkit-oathtool \
        python3
RUN rm /var/cache/apk/*

# Install specific infracos.io linux version
RUN curl -s -L https://github.com/infracost/infracost/releases/download/${INFRACOST_VERSION}/infracost-linux-amd64.tar.gz | tar xz -C /tmp && \
mv /tmp/infracost-linux-amd64 /usr/local/bin/infracost

ENTRYPOINT ["terraform"]
