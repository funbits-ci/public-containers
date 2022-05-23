# Gitpod Image


```shell
export VSCODE_VERSION=v1.65.2
export GITPOD_RELEASE_TAG=openvscode-server-$VSCODE_VERSION
docker build --build-arg RELEASE_TAG=$GITPOD_RELEASE_TAG -t harbor.beyond.cc/bitspire-public/vscode:latest .

docker push harbor.beyond.cc/bitspire-public/vscode:latest
docker push harbor.beyond.cc/bitspire-public/vscode:$VSCODE_VERSION

```
Reference:
- https://www.gitpod.io/docs/config-docker/
