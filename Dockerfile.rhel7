FROM registry.access.redhat.com/rhel7.1 
MAINTAINER crunchy

# Install postgresql deps
RUN rpm -Uvh http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-redhat94-9.4-1.noarch.rpm
RUN yum -y install libxslt libxml2 procps-ng postgresql94 postgresql94-server postgresql94-contrib openssh-clients hostname bind-utils && yum clean all -y

#Added by gmillard@redhat.com
#

LABEL Name crunchydata/crunchy-postgresql:9.4.2
LABEL Release Version crunchy-postgresql:9.4.2
LABEL Vendor Crunchy Data Systems
LABEL Version 9.4.2


# set up cpm directory
#
RUN mkdir -p /opt/cpm/bin
RUN mkdir -p /opt/cpm/conf

RUN chown -R postgres:postgres /opt/cpm

# set environment vars
ENV PGROOT /usr/pgsql-9.4
ENV PGDATA /pgdata

# add path settings for postgres user
ADD conf/.bash_profile /var/lib/pgsql/

# add volumes to allow backup of postgres files
VOLUME ["/pgdata"]
RUN chown -R postgres:postgres /pgdata

# open up the postgres port
EXPOSE 5432

ADD bin /opt/cpm/bin
ADD conf /opt/cpm/conf

USER postgres

CMD ["/opt/cpm/bin/start.sh"]

