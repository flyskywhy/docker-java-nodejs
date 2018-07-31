FROM beevelop/java

MAINTAINER Li Zheng <flyskywhy@gmail.com>

# NODEJS_VERSION here refers to [Node.js Packer](https://github.com/pmq20/node-packer)

ENV NODEJS_VERSION=8.3.0 \
    GIT_VERSION=2.7.4 \
    ANT_HOME="/usr/share/ant" \
    MAVEN_HOME="/usr/share/maven" \
    GRADLE_HOME="/usr/share/gradle" \
    PATH=$PATH:/opt/node/bin:$ANT_HOME/bin:$MAVEN_HOME/bin:$GRADLE_HOME/bin

RUN rm /bin/sh \
    && ln -s /bin/bash /bin/sh \
    && dpkg --add-architecture i386 \
    && apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends \
        ant \
        autoconf \
        build-essential \
        ca-certificates \
        checkinstall \
        curl \
        dpkg-dev \
        gettext \
        gradle \
        libcurl4-openssl-dev \
        libexpat1-dev \
        libncurses5:i386 \
        libstdc++6:i386 \
        libssl-dev \
        libz-dev \
        maven \
        openssh-client \
        python \
        python-dev \
        python-distribute \
        python-pip \
        rsync \
        ruby \
        squashfs-tools \
        sshpass \
        wget \
        zlib1g:i386 \
    && mkdir -p /opt/git \
    && cd /opt/git \
    && curl -sL https://codeload.github.com/git/git/tar.gz/v${GIT_VERSION} | tar xz --strip-components=1\
    && make configure \
    && ./configure --with-openssl --with-curl \
    && make \
    && make install \
    && cd .. \
    && rm -fr git \
    && mkdir -p /opt/node \
    && cd /opt/node \
    && curl -sL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz | tar xz --strip-components=1 \
    && npm config set registry https://registry.npm.taobao.org \
    && npm config set unsafe-perm=true \
    && npm install -g \
        ali-cdn-cli@1.0.1 \
        bunyan@1.8.12 \
        mocha@3.5.3 \
        pm2@2.10.1 \
        react-native-cli@2.0.1 \
        supervisor@0.12.0 \
    && npm cache clean --force \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
    && apt-get autoremove -y \
    && apt-get clean
