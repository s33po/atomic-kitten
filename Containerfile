FROM scratch AS context

ARG MAJOR_VERSION="${MAJOR_VERSION:-c10s}"

FROM quay.io/centos-bootc/centos-bootc:$MAJOR_VERSION

# Build stuff
COPY build.sh /tmp/build.sh
RUN chmod +x /tmp/build.sh &&\
    /tmp/build.sh

# Linting
RUN bootc container lint

# Make /opt writable and persistent
RUN rm -rf /opt && ln -s /var/opt /opt 