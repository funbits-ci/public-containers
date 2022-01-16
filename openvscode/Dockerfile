FROM debian:buster
FROM gcr.io/kaniko-project/executor:v1.7.0-debug as kaniko
FROM harbor.beyond.cc/bitspire-public/nix:2.3.15

RUN apt update && \
    apt install -y procps curl vim git wget sudo && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home/

ARG RELEASE_TAG
ARG RELEASE_ORG="gitpod-io"
ARG OPENVSCODE_SERVER_ROOT="/home/${RELEASE_TAG}"

# Downloading the latest VSC Server release and extracting the release archive
RUN if [ -z "${RELEASE_TAG}" ]; then \
        echo "The RELEASE_TAG build arg must be set." >&2 && \
        exit 1; \
    fi && \
    arch=$(uname -m) && \
    if [ "${arch}" = "x86_64" ]; then \
        arch="x64"; \
    elif [ "${arch}" = "aarch64" ]; then \
        arch="arm64"; \
    elif [ "${arch}" = "armv7l" ]; then \
        arch="armhf"; \
    fi && \
    wget https://github.com/${RELEASE_ORG}/openvscode-server/releases/download/${RELEASE_TAG}/${RELEASE_TAG}-linux-${arch}.tar.gz && \
    tar -xzf ${RELEASE_TAG}-linux-${arch}.tar.gz && \
    mv -f ${RELEASE_TAG}-linux-${arch} ${OPENVSCODE_SERVER_ROOT} && \
    rm -f ${RELEASE_TAG}-linux-${arch}.tar.gz

ARG USERNAME=openvscode-server
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Creating the user and usergroup
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USERNAME -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN chmod g+rw /home && \
    mkdir -p /home/workspace && \
    chown -R $USERNAME:$USERNAME /home/workspace && \
    chown -R $USERNAME:$USERNAME ${OPENVSCODE_SERVER_ROOT};


COPY --from=kaniko /kaniko/* /kaniko/
COPY --from=kaniko /busybox/ /busybox/

VOLUME /busybox

USER root
COPY --from=kaniko /kaniko/ssl/certs/ /kaniko/ssl/certs/

ENV PATH /nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/kaniko:/busybox
ENV DOCKER_CONFIG /kaniko/.docker/

RUN cp /kaniko/ssl/certs/* /etc/ssl/

RUN nix-channel --add https://github.com/NixOS/nixpkgs/archive/fce0206462cd8b80eaca59542d0c53713044050f.tar.gz nixos-unstable-2021-06-12
RUN nix-channel --update


COPY *.nix /opt/
RUN mkdir /opt/scala

# Run needed programs to force caching and print their version
RUN nix-shell /opt/shell.nix --run "cd /tmp && java -version"; \
    nix-shell /opt/shell.nix --run "cd /tmp && amm -c 'println(700 + 7)'"; \
    nix-shell /opt/shell.nix --run "cd /tmp && sbt --version"; \
    nix-shell /opt/shell.nix --run "cd /tmp && kubectl version --client=true"; \
    nix-shell /opt/shell.nix --run "cd /tmp && node --version";

RUN cp -r /root/.nix-* /home/workspace
RUN cp /root/.profile /home/workspace
RUN chown -R $USER_UID:$USER_GID /home/workspace
RUN chown -R $USER_UID:$USER_GID /nix

RUN wget https://github.com/facebook/watchman/releases/download/v2021.12.06.00/watchman-v2021.12.06.00-linux.zip \
    && unzip watchman-v2021.12.06.00-linux.zip \
    && cd watchman-v2021.12.06.00-linux \
    &&  mkdir -p /usr/local/{bin,lib} /usr/local/var/run/watchman \
    && cp bin/* /usr/local/bin \
    && cp lib/* /usr/local/lib \
    && chmod 755 /usr/local/bin/watchman \
    && chmod 2777 /usr/local/var/run/watchman \
    && cd .. && rm -r watchman-v2021.12.06.00-linux && rm watchman-v2021.12.06.00-linux.zip

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    HOME=/home/workspace \
    EDITOR=code \
    VISUAL=code \
    GIT_EDITOR="code --wait" \
    OPENVSCODE_SERVER_ROOT=${OPENVSCODE_SERVER_ROOT}

USER $USERNAME
WORKDIR /home/workspace/


EXPOSE 3030

ENTRYPOINT [ "/bin/sh", "-c", "exec ${OPENVSCODE_SERVER_ROOT}/server.sh --port 3030 \"${@}\"", "--" ]
