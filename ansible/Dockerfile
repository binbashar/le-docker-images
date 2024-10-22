FROM python:3.9-slim-buster
LABEL vendor="Binbash Leverage (info@binbash.com.ar)"

ARG DOCKER_TAG
ARG ANSIBLE_VERSION=${DOCKER_TAG}

ENV PY_PIP_VER=20.2.4
ENV PY_PIP_PKGS="ansible==${ANSIBLE_VERSION} jmespath==0.10.0 boto3==1.28.5"

#
# Installing dependencies
#
RUN apt-get update \
  && apt-get install -y git unzip curl \
	&& apt-get clean

# Install Ansible via Pip.
RUN pip3 install --upgrade pip==${PY_PIP_VER}
RUN pip3 install wheel
RUN pip3 install ${PY_PIP_PKGS}

# Install SSM Session Manager Plugin
RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb" && \
    dpkg -i session-manager-plugin.deb && \
    rm session-manager-plugin.deb

# Remove unnecessary getty and udev targets that result in high CPU usage when using
# multiple containers with Molecule (https://github.com/ansible/molecule/issues/1104)
RUN rm -f /lib/systemd/system/systemd*udev* \
  && rm -f /lib/systemd/system/getty.target

ENTRYPOINT ["ansible"]
