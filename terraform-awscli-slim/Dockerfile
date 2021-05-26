ARG DOCKER_TAG
ARG TERRAFORM_VERSION=${DOCKER_TAG}

FROM hashicorp/terraform:${TERRAFORM_VERSION}

LABEL vendor="Binbash Leverage (info@binbash.com.ar)"

ARG AWSCLI_VERSION=1.19.67
ARG KUBECTL_VERSION=v1.21.0

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

# Install latest pip3 and AWS CLI
RUN python3 -m ensurepip && \
        python3 -m pip install --upgrade pip && \
        rm -r /usr/lib/python*/ensurepip && \
        pip3 install awscli==${AWSCLI_VERSION}

RUN curl -LO https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
        chmod +x kubectl && \
        mv kubectl /usr/local/bin

ENTRYPOINT ["terraform"]
