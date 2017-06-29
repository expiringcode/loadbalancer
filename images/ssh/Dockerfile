FROM debian:jessie

RUN apt-get update && apt-get install -y --no-install-recommends \
	openssh-client\
	openssh-server

RUN mkdir -p /var/run/sshd

RUN rm -Rf /etc/ssh/sshd_config /etc/issue.net && mkdir -p /etc/ssh
COPY ./conf/sshd_config /etc/ssh/sshd_config
COPY ./conf/issue.net /etc/issue.net
COPY ./conf/authorized_keys ~/.ssh/authorized_keys

EXPOSE 2222

COPY entrypoint /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint
ENTRYPOINT ["entrypoint"]

CMD    ["/usr/sbin/sshd", "-D"]