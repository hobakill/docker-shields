FROM beevelop/nodejs-python

MAINTAINER Maik Hummel <m@ikhummel.com>

WORKDIR /opt

ENV GH_CLIENT_ID=null \
    GH_CLIENT_SECRET=null \
    DOCKER_HUB_TOKEN=null \
    INFOSITE="http://shields.io"

RUN apt-get update && apt-get install -y pkg-config libcairo2-dev git gettext && \
    git clone https://github.com/hobakill/shields && cd shields && \
    npm i

COPY secret.tpl.json ./shields/
RUN mkdir -p /opt/shields/private

CMD envsubst < /opt/shields/secret.tpl.json > /opt/shields/private/secret.json && node shields/server.js

EXPOSE 80
