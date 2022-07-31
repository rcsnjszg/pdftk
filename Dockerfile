FROM ubuntu:22.04

RUN apt update && \
    apt install -y \
        pdftk

WORKDIR /app

ENTRYPOINT ["pdftk"]