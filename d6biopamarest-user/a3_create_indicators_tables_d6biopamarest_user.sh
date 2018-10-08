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


# INDICATORS (example)
## create table topography.gebco_wdpa

list="\
topography.gebco_wdpa
"

for l in ${list}
do

	sch=`echo ${l} | cut -d'.' -f1`

	tab=`echo ${l} | cut -d'.' -f2`

	echo "going in schema " ${sch}

	echo "creating table " ${tab}

	#create table
	psql ${dbpar2} -f ${SQL}/${sch}/${tab}.sql;
	# IMPORT TARGET TABLE
	echo "\copy ${sch}.${tab} FROM ${ipath}/${sch}.${tab}.csv delimiter '|' CSV;" | psql ${dbpar2};

done

