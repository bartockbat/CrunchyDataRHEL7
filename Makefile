VERSION=0.2.0

OSFLAVOR=rhel7

all:
ifeq ($(OSFLAVOR),centos7)
	cp Dockerfile.centos7 Dockerfile
else
	cp Dockerfile.rhel7 Dockerfile
endif
	        docker build -t crunchydata/crunchy-postgresql:9.4.2 .

