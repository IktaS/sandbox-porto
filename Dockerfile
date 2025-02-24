FROM alpine:edge
RUN apk update
RUN apk upgrade
RUN apk add nano
RUN apk add neofetch
ADD ./scripts /scripts
RUN chmod +x /scripts/setup_user.sh
RUN /scripts/setup_user.sh
ADD ./public/profile.jpg /assets/profile.jpg
ENTRYPOINT [ "tail", "-f", "/dev/null" ]