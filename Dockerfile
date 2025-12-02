FROM ghcr.io/typst/typst:0.14.0 AS builder
ADD ./scripts/basic-typst-resume-template-html /scripts/basic-typst-resume-template-html
ADD ./scripts/cv.typ /scripts/cv.typ
RUN typst compile --format html /scripts/cv.typ --features html cv.html
FROM alpine:edge
RUN apk update
RUN apk upgrade
RUN apk add fastfetch
RUN apk add bash
RUN apk add git
RUN apk add lynx
ADD ./scripts/setup_user.sh /scripts/setup_user.sh
ADD ./scripts/.bashrc /scripts/.bashrc
ADD ./scripts/config.jsonc /scripts/config.jsonc
RUN chmod +x /scripts/setup_user.sh
RUN /scripts/setup_user.sh
COPY --from=builder /cv.html /home/visitor/cv.html
ENTRYPOINT [ "tail", "-f", "/dev/null" ]
