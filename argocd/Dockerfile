FROM argoproj/argocd:v2.2.2

USER root

ENV KBLD_URL=https://github.com/vmware-tanzu/carvel-kbld/releases/download/v0.32.0/kbld-linux-amd64

ADD https://dl.yarnpkg.com/debian/pubkey.gpg /tmp/pubkey.gpg
RUN apt-key add /tmp/pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && \
    apt-get install -y \
        curl \
        awscli \
        gpg \
        yarn \
        python3-pip \
    && apt-get clean \
    && curl -L -o /usr/local/bin/kbld ${KBLD_URL} \
    && chmod +x /usr/local/bin/kbld

RUN yarn global add npm cdk8s-cli typescript

USER 999

