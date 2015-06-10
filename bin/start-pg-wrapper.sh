#!/bin/bash

# Copyright 2015 Crunchy Data Solutions, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# start pg, will initdb if /pgdata is empty as a way to bootstrap
#

source /opt/cpm/bin/setenv.sh

#
# the initial start of postgres will create the database
#
if [ ! -f /pgdata/postgresql.conf ]; then
        echo "pgdata is empty"
        initdb -D /pgdata  > /tmp/initdb.log &> /tmp/initdb.err

	echo "overlay pg config with your settings...."
        cp /opt/cpm/conf/postgresql.conf /pgdata/
        cp /opt/cpm/conf/pg_hba.conf /pgdata/

        echo "starting db" >> /tmp/start-db.log

        pg_ctl -D /pgdata start
        sleep 3

        echo "loading setup.sql" >> /tmp/start-db.log
	sed -i "s/CRUNCHY_USER/$CRUNCHY_USER/g" /opt/cpm/bin/setup.sql
	sed -i "s/CRUNCHY_PSW/$CRUNCHY_PSW/g" /opt/cpm/bin/setup.sql
	sed -i "s/CRUNCHY_DB/$CRUNCHY_DB/g" /opt/cpm/bin/setup.sql

        psql -U postgres < /opt/cpm/bin/setup.sql
        exit
fi

#
# clean up any old pid file that might have remained
# during a bad shutdown of the container/postgres
#
rm /pgdata/postmaster.pid
#
# the normal startup of pg
#
pg_ctl -D /pgdata start 

