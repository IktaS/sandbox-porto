FROM golang:alpine AS builder
WORKDIR /src/app
RUN wget https://github.com/charmbracelet/glow/releases/download/v2.1.0/glow-2.1.0.tar.gz
RUN tar -xf glow-2.1.0.tar.gz
RUN go build -o glow
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
COPY --from=builder /src/app/glow /bin/glow
ENTRYPOINT [ "tail", "-f", "/dev/null" ]