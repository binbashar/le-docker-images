ARG DOCKER_TAG
ARG TERRAFORM_VERSION=${DOCKER_TAG}

FROM hashicorp/terraform:${TERRAFORM_VERSION}

LABEL vendor="Binbash Leverage (info@binbash.com.ar)"

ARG AWSCLI_VERSION=1.19.67
ARG AWSVAULT_VERSION=v6.3.1

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

# Add aws-mfa script
RUN mkdir -p /root/scripts/aws-mfa && \
        curl https://raw.githubusercontent.com/binbashar/le-tf-infra-aws-template/v0.3.0/le-resources/scripts/aws-mfa/aws-mfa-entrypoint.sh > /root/scripts/aws-mfa/aws-mfa-entrypoint.sh && \
        curl https://raw.githubusercontent.com/binbashar/le-tf-infra-aws-template/v0.3.0/le-resources/scripts/aws-mfa/aws-non-mfa-entrypoint.sh > /root/scripts/aws-mfa/aws-non-mfa-entrypoint.sh
RUN chmod +x /root/scripts/aws-mfa/*

# Add aws-vault
RUN curl -LO https://github.com/99designs/aws-vault/releases/download/${AWSVAULT_VERSION}/aws-vault-linux-amd64 \
        && chmod +x aws-vault-linux-amd64 \
        && mv aws-vault-linux-amd64 /usr/local/bin/aws-vault

ENTRYPOINT ["terraform"]
