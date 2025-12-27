FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssh-server python3 sudo

RUN mkdir -p /run/sshd

# Create user for test environment
RUN useradd -rm -d /home/ansible-test -s /bin/bash -g root -G sudo test-admin && \
    echo 'test-admin:password' | chpasswd

# Create user for uat environment
RUN useradd -rm -d /home/ansible-uat -s /bin/bash -g root -G sudo uat-admin && \
    echo 'uat-admin:password' | chpasswd

# Create user for prd environment
RUN useradd -rm -d /home/ansible-prd -s /bin/bash -g root -G sudo prd-admin && \
    echo 'prd-admin:password' | chpasswd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]