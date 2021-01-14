ARG BASE_HELMSMAN_IMAGE=praqma/helmsman:v3.4.3-helm-v3.2.1

#
# Build image for aws-iam-authenticator
#
FROM alpine:3.12.3 AS aws-iam-authenticator
LABEL vendor="Binbash Leverage (info@binbash.com.ar)"

# Install aws-iam-authenticator
WORKDIR /opt
ENV AWS_IAM_AUTHENTICATOR_VERSION=${AWS_IAM_AUTHENTICATOR_VERSION}
RUN wget -O aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.5.2/aws-iam-authenticator_0.5.2_linux_amd64
RUN chmod +x aws-iam-authenticator


#
# Build image for helmsman and helm
#
FROM ${BASE_HELMSMAN_IMAGE} AS helmsman


#
# Final image with helmsman, helm and aws-iam-authenticator
#
FROM alpine:3.12.3 AS main
LABEL vendor="Binbash Leverage (info@binbash.com.ar)"

# Copy helmsman and helm from praqma
COPY --from=helmsman /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=helmsman /bin/helmsman /usr/local/bin/helmsman
COPY --from=helmsman /usr/local/bin/helm /usr/local/bin/helm
COPY --from=helmsman /root/.cache/helm/plugins/ /root/.cache/helm/plugins/
COPY --from=helmsman /root/.local/share/helm/plugins/ /root/.local/share/helm/plugins/

# Copy aws-iam-authenticator
COPY --from=aws-iam-authenticator /opt/aws-iam-authenticator /usr/local/bin/aws-iam-authenticator

ENTRYPOINT ["helmsman"]
