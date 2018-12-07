FROM debian:stretch
LABEL mantainer "hacklab/ <contato@hacklab.com.br>"

RUN apt update && apt install -y \
            openssh-server \
            nmap \
            curl \
            tcpdump \
            jq \
            wget \
            rsync \
    && apt-get clean -y

RUN mkdir /var/run/sshd && \
    echo 'root:cweqwcp092qa' | chpasswd && \
    sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "export VISIBLE=now" >> /etc/profile

COPY authorized_keys /root/.ssh/authorized_keys

EXPOSE 22
CMD /usr/sbin/sshd -D
