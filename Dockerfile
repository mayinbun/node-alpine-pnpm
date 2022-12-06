## Node alpine with git

ARG PNPM_VERSION=7.18.1

FROM node:16-alpine

RUN set -x \
    && . /etc/os-release \
    && case "$ID" in \
        alpine) \
            apk add --no-cache bash curl git openssh \
            ;; \
        debian) \
            apt-get update \
            && apt-get -yq install bash git openssh-server \
            && apt-get -yq clean \
            && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
            ;; \
    esac \
    && pnpm bin || ( npm install --global pnpm@${PNPM_VERSION} && npm cache clean --force ) \
    && git --version && bash --version && ssh -V && npm -v && node -v && pnpm -v