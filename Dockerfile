FROM centos:7.4.1708
RUN yum -y update && \
    yum -y install epel-release

RUN yum -y update && \
    yum -y install epel-release && \
    yum -y update && \
    yum -y install \
        gcc \
        haveged \
        libffi-devel \
        openssl-devel \
        postgresql \
        postgresql-devel \
        postgresql-client \
        python34 \
        python34-devel \
        python34-pip \
	git \
	supervisor

RUN adduser psono && \
    su psono -c 'git clone https://gitlab.com/psono/psono-server.git ~/psono-server' && \
    cd /home/psono/psono-server && \
    pip3 install -r requirements.txt && \
    pip3 install uwsgi && \
    pip3 install typing && \
    pip3 install --upgrade pip && \
    pip3 install gunicorn && \
    su psono -c 'mkdir ~/.psono_server'

COPY psono-server.ini /etc/supervisord.d/
COPY settings.yaml /home/psono/.psono_server/settings.yaml

RUN yum install nginx -y
COPY vhost.conf /etc/nginx/conf.d/
COPY server.key /etc/ssl/server.key
COPY server.crt /etc/ssl/server.crt
RUN systemctl enable supervisord && \
    systemctl enable nginx
CMD ["/sbin/init"]
EXPOSE 80 443 10100 10101 10102
#RUN python3  ~/psono-server/psono/manage.py createuser bientd88@bientd88.com change_me bientd88@bientd88.com
#RUN python3 ~/psono-server/psono/manage.py promoteuser bientd88@bientd88.com superuser
# docker run --rm --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name poc -d pad /sbin/init
