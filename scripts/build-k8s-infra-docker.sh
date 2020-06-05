#!/bin/bash

set -e

if [ -z ${GOPATH} ]; then
    echo "\"GOPATH\" environmental variable is not set";
    exit 1
fi

if [ -z ${version} ]; then
    echo "\"version\" environmental variable is not set";
    exit 1
fi

cd $GOPATH

for binary_name in nuage-k8s-infra
do
    sudo docker run --rm -v `pwd`:/go -w /go golang:1.13 go build -v -o $binary_name github.com/nuagenetworks/nuage-k8s-infra
    mv $binary_name $GOPATH/src/github.com/nuagenetworks/nuage-k8s-infra
done

cd $GOPATH/src/github.com/nuagenetworks/nuage-k8s-infra

sudo docker build --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} --build-arg no_proxy=${no_proxy} -t nuage/infra:${version} .
sudo docker save nuage/infra:${version} > nuage-infra-docker-${version}.tar
sudo docker rmi nuage/infra:${version}
