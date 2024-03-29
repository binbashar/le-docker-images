ARG DOCKER_TAG
ARG TERRAFORM_VERSION=${DOCKER_TAG}

FROM hashicorp/terraform:${TERRAFORM_VERSION}

LABEL vendor="Binbash Leverage (info@binbash.com.ar)"

ARG GLIBC_VERSION=2.34-r0
ARG AWSCLI_VERSION=2.4.7
ARG AWSVAULT_VERSION=v6.3.1
ARG HCLEDIT_VERSION=0.2.2
ARG TEMPLATE_VERSION=0.3.1

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
        groff \
        jq \
        oath-toolkit-oathtool \
        python3
RUN rm /var/cache/apk/*

# Download and install glibc
# NOTE: Keep an eye on the issue https://github.com/aws/aws-cli/pull/6352 regarding installation of the AWS CLI from source in order to avoid
# the need of installing glibc
RUN curl -sL "https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub" -o /etc/apk/keys/sgerrand.rsa.pub \
        && curl -sLO "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" \
        && curl -sLO "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" \
        && apk add --no-cache \
        glibc-${GLIBC_VERSION}.apk \
        glibc-bin-${GLIBC_VERSION}.apk \
        && rm glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip" -o awscliv2.zip \
        && unzip awscliv2.zip \
        && ./aws/install \
        && rm -rf awscliv2.zip aws

# Add aws-mfa script
RUN mkdir -p /root/scripts/aws-mfa
RUN curl "https://raw.githubusercontent.com/binbashar/le-tf-infra-aws-template/v${TEMPLATE_VERSION}/le-resources/scripts/aws-mfa/aws-mfa-entrypoint.sh" > /root/scripts/aws-mfa/aws-mfa-entrypoint.sh
# Add aws-sso scripts
RUN mkdir -p /root/scripts/aws-sso
RUN curl "https://raw.githubusercontent.com/binbashar/le-tf-infra-aws-template/v${TEMPLATE_VERSION}/le-resources/scripts/aws-sso/aws-sso-configure.sh" > /root/scripts/aws-sso/aws-sso-configure.sh 
RUN curl "https://raw.githubusercontent.com/binbashar/le-tf-infra-aws-template/v${TEMPLATE_VERSION}/le-resources/scripts/aws-sso/aws-sso-login.sh" > /root/scripts/aws-sso/aws-sso-login.sh 
RUN curl "https://raw.githubusercontent.com/binbashar/le-tf-infra-aws-template/v${TEMPLATE_VERSION}/le-resources/scripts/aws-sso/aws-sso-logout.sh" > /root/scripts/aws-sso/aws-sso-logout.sh 
RUN curl "https://raw.githubusercontent.com/binbashar/le-tf-infra-aws-template/v${TEMPLATE_VERSION}/le-resources/scripts/aws-sso/aws-sso-entrypoint.sh" > /root/scripts/aws-sso/aws-sso-entrypoint.sh 

RUN chmod -R +x /root/scripts/

# Add aws-vault
RUN curl -LO "https://github.com/99designs/aws-vault/releases/download/${AWSVAULT_VERSION}/aws-vault-linux-amd64" \
        && chmod +x aws-vault-linux-amd64 \
        && mv aws-vault-linux-amd64 /usr/local/bin/aws-vault

# Install hcledit
RUN curl -LO "https://github.com/minamijoyo/hcledit/releases/download/v${HCLEDIT_VERSION}/hcledit_${HCLEDIT_VERSION}"_linux_amd64.tar.gz \
        && tar -xzf hcledit_${HCLEDIT_VERSION}_linux_amd64.tar.gz hcledit -C /usr/local/bin \
        && rm hcledit_${HCLEDIT_VERSION}_linux_amd64.tar.gz

ENTRYPOINT ["terraform"]
