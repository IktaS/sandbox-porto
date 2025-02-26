FROM alpine:edge
RUN apk update
RUN apk upgrade
RUN apk add fastfetch
RUN apk add bash
RUN apk add git
ADD ./scripts /scripts
RUN chmod +x /scripts/setup_user.sh
RUN /scripts/setup_user.sh
ADD ./public/profile.sixel /assets/profile.sixel
ENTRYPOINT [ "tail", "-f", "/dev/null" ]