Scripts to update d6biopamarest (as user).

After admin has updated the materialized views (see in ../d6biopamarest-admin), with following sequence compulsory:

1.  On dev stage: 
    *  ./create_main_tables_d6biopamarest_user.sh
    *  ./create_indicators_tables_d6biopamarest_user.sh
    *  ./create_indicators_tables_d6biopamarest_user.sh

2.  On update stage: edit in the following scripts the lists of tables to be updated, then:
    *  ./update_main_tables_d6biopamarest_user.sh
    *  ./update_derived_tables_d6biopamarest_user.sh
    *  ./update_indicators_tables_d6biopamarest_user.sh
