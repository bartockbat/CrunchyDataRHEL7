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

echo "starting crunchy-pg container..."
DATA_DIR=/tmp/crunchy-pg-data
sudo mkdir -p $DATA_DIR
sudo chown postgres:postgres $DATA_DIR
sudo chcon -Rt svirt_sandbox_file_t $DATA_DIR
sudo docker run \
	-p 12000:5432 \
	-e CRUNCHY_USER=testuser \
	-e CRUNCHY_PSW=testpsw \
	-e CRUNCHY_DB=testdb \
	--name=crunchy-pg -d -v $DATA_DIR:/pgdata crunchydata/crunchy-pg:latest

