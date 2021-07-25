FROM alpine:3.14.0

ENV PULSARCTL_VERSION v2.8.0.6

RUN wget -qO- https://github.com/streamnative/pulsarctl/releases/download/$PULSARCTL_VERSION/pulsarctl-amd64-linux.tar.gz | tar -xvzf - && \
          mv pulsarctl-amd64-linux/pulsarctl /usr/local/bin
