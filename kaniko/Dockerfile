## Start with the version of Kaniko that matches our defined version
ARG KANIKO_VERSION=latest
FROM gcr.io/kaniko-project/executor:v${KANIKO_VERSION}-debug AS kaniko

# Our base image runtime image
FROM debian:bullseye-slim

# Install the required packages
RUN apt-get -y update \
	&& apt-get install -y curl wget ca-certificates git ssh --no-install-recommends \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Copy everything over we need from the Kaniko image
RUN mkdir -p /kaniko \
	&& chmod 777 /kaniko
COPY --from=kaniko /kaniko/* /kaniko/
COPY --from=kaniko /kaniko/.docker /kaniko/.docker

# Ensure the execute bits are set appropriatly
RUN chmod +x /kaniko/executor \
	&& chmod +x /kaniko/docker-credential-*

# Rather than use Kaniko's ca-certificate bundle, use the one provided by the ca-certificates package
RUN rm /kaniko/certs/ca-certificates.crt \
	&& ln -sf /etc/ssl/certs/ca-certificates.crt /kaniko/certs/ca-certificates.crt

# Set the env vars like Kaniko does, but with our own PATH
ENV HOME /root
ENV USER root
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/kaniko
ENV SSL_CERT_DIR=/kaniko/ssl/certs
ENV DOCKER_CONFIG /kaniko/.docker/
ENV DOCKER_CREDENTIAL_GCR_CONFIG /kaniko/.config/gcloud/docker_credential_gcr_config.json

# Set the workspace and entrypoint like Kaniko does
WORKDIR /workspace
ENTRYPOINT ["/kaniko/executor"]
