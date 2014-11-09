FROM phusion/baseimage
MAINTAINER  eduStack Project "http://eduStack.org"
CMD ["/sbin/my_init"]
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y runit openssh-server rsyslog bash sudo openssl ca-certificates build-essential software-properties-common python-software-properties curl git-core libxml2-dev libxslt1-dev libfreetype6-dev python-pip python-apt python-dev
RUN pip install --upgrade pip
RUN pip install --upgrade virtualenv
RUN (cd /var/tmp && git clone -b docker_release https://github.com/eduStack/configuration)
RUN (cd /var/tmp/configuration && pip install -r requirements.txt)
WORKDIR /var/tmp/configuration/playbooks
RUN ansible-playbook -vvvv -c local --limit "localhost:127.0.0.1" -i "localhost," docker_lite.yml
