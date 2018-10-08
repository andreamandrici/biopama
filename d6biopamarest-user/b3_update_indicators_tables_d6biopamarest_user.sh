#!/bin/bash

# SET SOME VARIABLES
## paths
ipath="inputs"
opath="outputs"
SQL="sql"

## database parameters
HOST="pgsql96-srv1.jrc.org"
USER="d6biopama"
DB="d6biopamarest"
dbpar1="host=${HOST} user=${USER} dbname=${DB}"
dbpar2="-h ${HOST} -U ${USER} -d ${DB}"

list=${ipath}/*.csv

for l in ${list}
do
	il=$(basename "$l" .csv)

	sch=`echo ${il} | cut -d'.' -f1`

	tab=`echo ${il} | cut -d'.' -f2`

	dat=`date +%Y%m%d`


	echo ${il}

	echo ${sch}

	echo ${tab}

	echo ${dat}

	# EMPTY TARGET TABLE
	echo "TRUNCATE TABLE ${sch}.${tab};" | psql ${dbpar2};

	# IMPORT TARGET TABLE
	echo "\copy ${sch}.${tab} FROM ${ipath}/${sch}.${tab}.csv delimiter '|' CSV;" | psql ${dbpar2};

	# UPDATE TRACKER TABLE
	echo "DELETE FROM utils.tracker WHERE \"schema\"='${sch}' AND \"table\"='${tab}'" | psql ${dbpar2};
	echo "INSERT INTO utils.tracker (\"role\",\"schema\",\"table\",\"date\") VALUES ('${USER}','${sch}','${tab}',${dat})" | psql ${dbpar2};

done
