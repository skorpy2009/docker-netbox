FROM python:3.5

WORKDIR /opt/netbox

ARG BRANCH=v2.0.3
ARG URL=https://github.com/digitalocean/netbox.git
RUN git clone --depth 1 $URL -b $BRANCH . && \
    apt-get update -qq && apt-get install -y libldap2-dev libsasl2-dev libssl-dev graphviz && \
    pip install gunicorn django-auth-ldap && \
    pip install -r requirements.txt

ADD entrypoint.sh /entrypoint.sh
ADD configuration.py /opt/netbox/netbox/netbox/configuration.py
ADD gunicorn_config.py /opt/netbox/

ENTRYPOINT [ "/entrypoint.sh" ]

