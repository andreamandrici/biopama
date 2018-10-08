Scripts to update d6biopamarest DOPA shared data (as admin).

Run these scripts after administrator has refreshed materialized views in d6geo.

Execute:
*  **create_foreign_tables_d6biopamarest_admin.sh** script to drop/create:
    *  "_last" foreign data tables (*._last objects in the schema geo.*, taken from d6geo)
    *  "mv_" materialized views (mv_objects in the schema geo.*, readable by all, taken by above foreign data tables)
*  **refresh_materialized_views_d6biopamarest_admin.sh** script to:
    *  refresh the geo.mv_* objects and update them to the last version.

