FROM debian:latest

ARG USERNAME

RUN mkdir /var/run/sshd
RUN apt update && apt install -y openssh-server
RUN echo 'PermitEmptyPasswords yes' >> /etc/ssh/sshd_config
RUN sed -i 's/nullok_secure/nullok/' /etc/pam.d/common-auth

RUN groupadd -g 1000 ${USERNAME}
RUN useradd --uid 1000 --gid 1000 --groups root,sudo,adm,users --create-home --password '' --shell /bin/bash ${USERNAME}
RUN echo '%sudo ALL=(ALL) ALL' >> /etc/sudoers

WORKDIR /root
COPY . /root
RUN chmod +x /root/setup.sh

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

