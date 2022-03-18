FROM alpine:3.15

WORKDIR /code

RUN apk update && apk add curl

COPY ./entrypoint /code/entrypoint

ENTRYPOINT ["/code/entrypoint"]