FROM node:9-alpine

RUN apk --update add \
    sudo \
    openssl \
    bash \
    openssh \
    git

CMD [ "node" ]