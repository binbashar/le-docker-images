ARG DOCKER_TAG
ARG TERRAFORM_VERSION=${DOCKER_TAG}

FROM binbash/terraform-awscli-slim:${TERRAFORM_VERSION}

LABEL vendor="Binbash Leverage (info@binbash.com.ar)"

# Install Go
RUN set -ex && \
        apk add --no-cache \
        git \
        musl-dev \
        go

# Configure Go
ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH

RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin

RUN go env -w GO111MODULE=on
RUN go get github.com/gruntwork-io/terratest/modules/terraform

WORKDIR $GOPATH

ENTRYPOINT ["go"]
