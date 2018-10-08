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

	dat=`date +%Y%m%d`

	echo "going in schema " ${sch}

	echo "updating table" ${tab}

	echo ${dat}

	# EMPTY TARGET TABLE
	echo "TRUNCATE TABLE ${sch}.${tab};" | psql ${dbpar2};

	# IMPORT TARGET TABLE
	echo "INSERT INTO ${sch}.${tab} SELECT * FROM geo.mv_${tab}"| psql ${dbpar2};

	# UPDATE TRACKER TABLE
	echo "DELETE FROM utils.tracker WHERE \"schema\"='${sch}' AND \"table\"='${tab}'" | psql ${dbpar2};
	echo "INSERT INTO utils.tracker (\"role\",\"schema\",\"table\",\"date\") VALUES ('${USER}','${sch}','${tab}',${dat})" | psql ${dbpar2};

done
