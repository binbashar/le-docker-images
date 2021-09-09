FROM python:3.8-slim

LABEL vendor="Binbash Leverage (leverage@binbash.com.ar)"

RUN apt-get update &&\
    apt-get install -y git curl

# Install bats as node package
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g bats
## Install bats from source
# RUN git clone https://github.com/bats-core/bats-core.git /opt/bats
# RUN ln -s /opt/bats/bin/bats /usr/local/bin/bats
# Install other bats modules
RUN npm install -g --save-dev https://github.com/bats-core/bats-support
RUN npm install -g --save-dev https://github.com/bats-core/bats-assert

WORKDIR /leverage
# Install requirements for running unit tests
RUN curl -LO https://raw.githubusercontent.com/binbashar/leverage/master/dev-requirements.txt
RUN pip install -r dev-requirements.txt

ENTRYPOINT [ "/bin/bash" ]
