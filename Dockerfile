FROM alpine:3.7

RUN apk --update add \
    sudo \
    openssl \
    bash \
    curl \
    openssh \
    git

ENTRYPOINT ["/bin/sh"]