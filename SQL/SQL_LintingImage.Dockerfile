FROM alpine:3.15

RUN apk update && apk add bash python3 python3-dev py3-pip build-base curl

RUN python3 -m pip install wheel

RUN python3 -m pip install sqlfluff

RUN addgroup -S user && adduser -S hqiu -G user

USER hqiu
