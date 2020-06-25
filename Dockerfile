FROM registry.access.redhat.com/ubi8/ubi:latest

RUN yum install -y iptables iproute

ADD nuage-k8s-infra /usr/bin/nuage-k8s-infra
ADD scripts/nuage-k8s-infra-pod.sh /usr/bin/nuage-k8s-infra-pod.sh

CMD ["/usr/bin/nuage-k8s-infra-pod.sh"]
