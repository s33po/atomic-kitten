FROM scratch AS context

ARG MAJOR_VERSION
ARG IMAGE_NAME
ARG SHA_HEAD_SHORT

FROM quay.io/centos-bootc/centos-bootc:${MAJOR_VERSION}

ENV IMAGE_NAME=${IMAGE_NAME}

# Build stuff
COPY build.sh /tmp/build.sh
RUN chmod +x /tmp/build.sh &&\
    /tmp/build.sh

# Linting
RUN bootc container lint

# Make /opt writable and persistent
RUN rm -rf /opt && ln -s /var/opt /opt 