#!/bin/bash

# SET SOME VARIABLES
## paths
ipath="input"
opath="outputs"
SQL="sql"

## database parameters
HOST="pgsql96-srv1.jrc.org"
USER="h05mandand"
DB="d6biopamarest"
dbpar1="host=${HOST} user=${USER} dbname=${DB}"
dbpar2="-h ${HOST} -U ${USER} -d ${DB}"

# # SQL PART

# UTILS
## create table utils.tracker
psql ${dbpar2} -f ${SQL}/utils_tracker.sql

## geo
psql ${dbpar2} -f ${SQL}/"geo2.sql"
