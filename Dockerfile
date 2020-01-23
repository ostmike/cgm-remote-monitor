FROM node:10-alpine AS builder

MAINTAINER Nightscout Contributors

RUN apk add --no-cache --virtual .gyp \
        python \
        make \
        g++ 

RUN mkdir -p /opt/app
ADD . /opt/app
WORKDIR /opt/app
RUN chown -R node:node /opt/app
USER node

RUN npm install && \
  npm run postinstall && \
  npm run env && \
  npm audit fix

EXPOSE 1337

CMD ["node", "server.js"]

FROM builder AS artifact

RUN mkdir -p /opt/app
ADD . /opt/app
WORKDIR /opt/app
COPY --from=builder /opt/app/* /opt/app/
#RUN chown -R node:node /opt/app
USER node

EXPOSE 1337

CMD ["node", "server.js"]
