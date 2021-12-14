FROM docker:dind

LABEL vendor="Binbash Leverage (leverage@binbash.com.ar)"

RUN apk update &&\
    apk add --no-cache bash bash-completion ncurses git curl gcc musl-dev python3 python3-dev py3-pip

# Install bats from source
RUN git clone https://github.com/bats-core/bats-core.git && ./bats-core/install.sh /usr/local
# Install other bats modules
RUN git clone https://github.com/bats-core/bats-support.git
RUN git clone https://github.com/bats-core/bats-assert.git

# Needed as is mounted later on
RUN mkdir /root/.ssh
# Needed for git to run propertly
RUN touch /root/.gitconfig

WORKDIR /leverage
# Install requirements for running unit tests
RUN curl -LO https://raw.githubusercontent.com/binbashar/leverage/v1.3.0/dev-requirements.txt
RUN pip install -r dev-requirements.txt

# Make script to configure and start docker daemon the default entrypoint
COPY ./leverage-cli-testing-entrypoint.sh /.
RUN chmod +x /leverage-cli-testing-entrypoint.sh
ENTRYPOINT [ "/leverage-cli-testing-entrypoint.sh" ]
