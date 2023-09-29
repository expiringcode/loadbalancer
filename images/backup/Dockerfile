FROM alpine:3.18.4

WORKDIR /app

COPY ./images/backup/backup.sh ./backup

RUN apk update && apk add curl

CMD sh