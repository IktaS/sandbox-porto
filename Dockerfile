FROM alpine:3.11
RUN apk update
RUN apk upgrade
RUN apk add neofetch
RUN adduser -D visitor
ENTRYPOINT [ "tail", "-f", "/dev/null" ]