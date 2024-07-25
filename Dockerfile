FROM plantuml/plantuml-server:jetty

ARG MAINTAINER="Hajime Matsumoto <hajime.matsumoto@avap.co.jp>"
ARG DESCRIPTION="Plantuml"
ARG BUILD_DATE
ARG VCS_REF
ARG CI
ARG BUILD_USERNAME
ARG BUILD_JOB_ID
ARG BUILD_JOB_URL

LABEL \
    maintainer=$MAINTAINER \
    org.label-schema.description=$DESCRIPTION \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.schema-version="1.0" \
    jp.co.avap.ci=$CI \
    jp.co.avap.build-username=$BUILD_USERNAME \
    jp.co.avap.build-job-id=$BUILD_JOB_ID \
    jp.co.avap.build-job-url=$BUILD_JOB_URL

WORKDIR /work

USER root
RUN \
apt-get update && \
apt-get install -y --no-install-recommends \
    wget \
    git \
    unzip && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

RUN \
    wget https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip -O NotoSansCJKjp-hinted.zip && \
    mkdir -p /usr/share/fonts/NotoSansCJKjp &&\
    unzip NotoSansCJKjp-hinted.zip -d /usr/share/fonts/NotoSansCJKjp/ &&\
    rm NotoSansCJKjp-hinted.zip && \
    fc-cache --force
 
USER jetty
