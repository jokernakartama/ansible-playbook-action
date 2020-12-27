FROM alpine

ENV ANSIBLE_HOST_KEY_CHECKING=False

RUN apk add --update py3-pip ansible rsync openssh gcc python3-dev libc-dev libffi-dev openssl-dev
RUN ln -s /usr/bin/python3 /usr/bin/python && \
    pip3 install --upgrade paramiko
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
