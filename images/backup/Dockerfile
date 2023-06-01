FROM alpine:3.16.5

WORKDIR /app

COPY ./images/backup/backup.sh ./backup

RUN apk update && apk add curl

CMD sh