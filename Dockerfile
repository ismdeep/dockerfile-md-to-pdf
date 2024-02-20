FROM debian:11
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai \
    NODE_VERSION="v18.18.2" \
    PATH="/usr/share/node-v18/bin:${PATH}"
RUN set -e; \
    apt-get update; \
    apt-get upgrade -y; \
    # Install basic tools
    apt-get install -y apt-transport-https ca-certificates tzdata; \
    apt-get install -y -qq curl wget pv xz-utils gettext-base rsync; \
    apt-get install -y -qq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 \
                       libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
                       libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
                       libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
                       ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils \
                      libgbm-dev; \
    # Install fonts
    apt-get install -y -qq ttf-wqy-zenhei; \
    # Install nodejs
    curl -fSL "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz" --create-dirs -o "/usr/share/node-${NODE_VERSION}-linux-x64.tar.xz"; \
    xz -cdk "/usr/share/node-${NODE_VERSION}-linux-x64.tar.xz" | tar -C /usr/share -x; \
    rm -rf  "/usr/share/node-${NODE_VERSION}-linux-x64.tar.xz"; \
    mv /usr/share/node-${NODE_VERSION}-linux-x64/ /usr/share/node-v18/; \
    npm install -g npm@latest; \
    # Install md-to-pdf
    npm install -g md-to-pdf