FROM node:14-alpine3.12 as runtime
ADD entrypoint.sh /entrypoint.sh
WORKDIR /
RUN chmod 777 entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN apk add --no-cache coreutils bats

FROM runtime
