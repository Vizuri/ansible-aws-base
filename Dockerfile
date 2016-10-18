FROM centos:centos7
MAINTAINER Isaac Christoffersen <ichristoffersen@vizuri.com>

WORKDIR /home/vizuri

RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install git python python-dev python-pip ansible; \
    yum clean all

RUN pip install --upgrade \
    pysphere \
    boto \
    pip \
    requests \
    awscli \
    toml

RUN echo -e '[local]\nlocalhost' > /etc/ansible/hosts
COPY configs/ansible.cfg /etc/ansible/ansible.cfg

RUN useradd vizuri; \
    echo 'vizuri  ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    chown -R vizuri:vizuri /home/vizuri
COPY configs/bashrc /home/vizuri/.bashrc


ENTRYPOINT ["/bin/bash"]
