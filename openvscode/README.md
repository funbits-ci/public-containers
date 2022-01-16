# Gitpod Image


```shell
export VSCODE_VERSION=v1.64.0
export GITPOD_RELEASE_TAG=openvscode-server-insiders-$VSCODE_VERSION
docker build --build-arg RELEASE_TAG=$GITPOD_RELEASE_TAG -t harbor.beyond.cc/bitspire-public/vscode:latest .

docker push harbor.beyond.cc/bitspire-public/vscode:latest 
docker push harbor.beyond.cc/bitspire-public/vscode:$VSCDE_VERSION

```
Reference:
- https://www.gitpod.io/docs/config-docker/
