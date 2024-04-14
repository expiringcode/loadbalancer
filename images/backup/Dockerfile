FROM alpine:3.16.9

WORKDIR /app

COPY ./images/backup/backup.sh ./backup

RUN apk update && apk add curl

CMD sh