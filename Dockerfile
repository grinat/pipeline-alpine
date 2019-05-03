FROM node:12-alpine

# Update apk and install jdk for selenium
RUN apk -U add openjdk8-jre

# Install chromium
RUN apk --no-cache \
	--allow-untrusted add \
    zlib-dev \
    chromium \
    chromium-chromedriver \
    xvfb \
    wait4ports \
    xorg-server \
    dbus \
    ttf-freefont \
    mesa-dri-swrast \
    grep \
    udev \
    && apk del --purge --force linux-headers binutils-gold gnupg zlib-dev libc-utils

ENV CHROME_BIN=/usr/bin/chromium-browser
ENV CHROME_PATH=/usr/lib/chromium/
ENV CHROME_DRIVER_PATH=/usr/bin/chromedriver

# For run chromium:
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

# install additionall apps
RUN apk --no-cache add \
    sudo \
    openssl \
    bash \
    openssh \
    curl \
    wget \
    git \
    nano \
    zip

RUN rm -rf /var/lib/apt/lists/* \
    /var/cache/apk/* \
    /usr/share/man/* \
    /tmp/*

# Testing node, selenium, chrome, nigthwatch
# https://peter.sh/experiments/chromium-command-line-switches/
# RUN /usr/bin/chromium-browser --dump-dom --headless --disable-gpu --no-sandbox https://chromium.org
COPY ./test /test
RUN cd /test && npm i && npm run e2e && rm -rf /test

CMD [ "node" ]
