FROM alpine:latest

WORKDIR /code

RUN apk update && apk add curl

COPY ./entrypoint /code/entrypoint

ENTRYPOINT ["/code/entrypoint"]