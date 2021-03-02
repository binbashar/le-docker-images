FROM python:3.8-slim-buster
LABEL vendor="Binbash Leverage (info@binbash.com.ar)"

ARG DOCKER_TAG
ARG ANSIBLE_VERSION=${DOCKER_TAG}

ENV PY_PIP_VER=20.2.4
ENV PY_PIP_PKGS="ansible==${ANSIBLE_VERSION} yamllint ansible-lint flake8 molecule"

#
# Installing dependencies
#
RUN apt-get update \
  && apt-get install -y git unzip \
	&& apt-get clean

# Install Ansible via Pip.
RUN pip3 install --upgrade pip==${PY_PIP_VER}
RUN pip3 install wheel
RUN pip3 install ${PY_PIP_PKGS}

# Remove unnecessary getty and udev targets that result in high CPU usage when using
# multiple containers with Molecule (https://github.com/ansible/molecule/issues/1104)
RUN rm -f /lib/systemd/system/systemd*udev* \
  && rm -f /lib/systemd/system/getty.target

ENTRYPOINT ["ansible"]
