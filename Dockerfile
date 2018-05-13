FROM node:9-alpine

RUN apk --update add \
    sudo \
    openssl \
    bash \
    openssh \
    curl \
    wget \
    git

CMD [ "node" ]