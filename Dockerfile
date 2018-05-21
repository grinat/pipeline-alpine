FROM node:9-alpine

RUN apk --update add \
    sudo \
    openssl \
    bash \
    openssh \
    curl \
    wget \
    git \
    nano

# added chromium
# chromeOptions: {
#            args: [
#              '--no-sandbox',
#              '--headless',
#              '--disable-gpu',
#              '--disable-translate',
#              '--disable-extensions'
#            ],
#            binary: '/usr/bin/chromium-browser'
#          }
RUN \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk --no-cache  update \
  && apk --no-cache  upgrade \
  && apk add --no-cache --virtual .build-deps \
    gifsicle pngquant optipng libjpeg-turbo-utils \
    udev ttf-opensans chromium \
  && rm -rf /var/cache/apk/* /tmp/*

ENV CHROME_BIN /usr/bin/chromium-browser
ENV LIGHTHOUSE_CHROMIUM_PATH /usr/bin/chromium-browser

CMD [ "node" ]