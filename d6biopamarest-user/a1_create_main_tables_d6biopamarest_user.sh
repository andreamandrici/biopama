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

list="\
administrative_units.country_atts \
administrative_units.gaul_eez \
administrative_units.gaul_eez_dissolved \
protected_sites.wdpa \
habitats_and_biotopes.ecoregions
"

for l in ${list}
do

	sch=`echo ${l} | cut -d'.' -f1`

	tab=`echo ${l} | cut -d'.' -f2`

	echo "going in schema " ${sch}

	echo "creating table " ${tab}

	# IMPORT TARGET TABLE
	psql ${dbpar2} -f ${SQL}/${sch}/${tab}.sql;

done
