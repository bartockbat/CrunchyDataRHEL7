Crunchy PostgreSQL 9.4.2
==========================

NOTE: The Makefile included creates a Docker container with the proper nomenclature for the registry.
The Dockerfile contains the LABELS metadata as per the future requirements.

gmillard@redhat.com

This project includes a Dockerfile that lets you build
a PostgreSQL 9.4.2 Docker image.  The image by default
is built on a RHEL 7.1 64 bit base, but can also be built
on a centos 7 64 bit base.  NOTICE, to build the RHEL 7 
version of this container, you need to build the Docker
container on a licensed RHEL 7 host!

Installation
------------

Builds are done by issuing the make command:
~~~~~~~~~~~~~~~~~~~~~
make
~~~~~~~~~~~~~~~~~~~~~
 

Running Postgresql
------------

To create the Docker container, you will need to have
PostgreSQL installed on your local machine.  This is 
due to the requirement of setting the data directory
ownership to the postgres user and also you will need
the psql command to test the container.

To install PostgreSQL locally, run the following:
~~~~~~~~~~~~~~~~~~~~~
sudo rpm -Uvh http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-redhat94-9.4-1.noarch.rpm
sudo yum -y install postgresql94-server postgresql94
~~~~~~~~~~~~~~~~~~~~~

Run the container with this command:
~~~~~~~~~~~~~~~~~~~~~
./run-pg.sh
~~~~~~~~~~~~~~~~~~~~~

This script will start up a container named crunchy-pg, it will
create a data directory for the database in /tmp/crunchy-pg-data.

It will initialize the database using the passed in environment
variables, building a user, database, schema, and table based
on the environment variable values.

The script also maps the PostgreSQL port of 5432 in the container
to your local host port of 12000.


Connecting to  PostgreSQL
------------

The container creates a default database called 'testdb', a default
user called 'testuser' with a default password of 'testpsw', you can
use this to connect from your local host as follows:
~~~~~~~~~~~~~~~~~~~~~
psql -h localhost -p 12000 -U testuser -W testdb
~~~~~~~~~~~~~~~~~~~~~


Shutting Down 
------------

To shut down the instance, run the following commands:

~~~~~~~~~~~~~~~~~~~~~
docker stop crunchy-pg
~~~~~~~~~~~~~~~~~~~~~
	

To start the instance, run the following commands:

~~~~~~~~~~~~~~~~~~~~~
docker start crunchy-pg
~~~~~~~~~~~~~~~~~~~~~
	
