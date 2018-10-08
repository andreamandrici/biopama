-- POPULATE CENTROIDS O25 FUNCTION;
DROP FUNCTION IF EXISTS protected_sites.f_pop_wdpa_centroids();
CREATE OR REPLACE FUNCTION protected_sites.f_pop_wdpa_centroids()
RETURNS SETOF protected_sites.wdpa_centroids
LANGUAGE 'sql' AS
$BODY$
SELECT
wdpaid,
name::text,
st_pointonsurface(geom) the_geom
FROM protected_sites.wdpa
WHERE area_geo >= 25::double precision;
$BODY$;
GRANT EXECUTE ON FUNCTION protected_sites.f_pop_wdpa_centroids() TO h05mandand;
GRANT EXECUTE ON FUNCTION protected_sites.f_pop_wdpa_centroids() TO d6biopama;
GRANT EXECUTE ON FUNCTION protected_sites.f_pop_wdpa_centroids() TO h05ibexro;
GRANT EXECUTE ON FUNCTION protected_sites.f_pop_wdpa_centroids() TO h05ibex;
COMMENT ON FUNCTION protected_sites.f_pop_wdpa_centroids() IS 'populate last version of wdpa over 25 sqkm (points)|FALSE|';