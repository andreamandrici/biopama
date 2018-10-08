-- CENTROIDS TABLE
DROP TABLE IF EXISTS protected_sites.wdpa_centroids CASCADE;
CREATE TABLE protected_sites.wdpa_centroids (
wdpaid integer PRIMARY KEY,
"name" text,
the_geom geometry(Point,4326)
);
GRANT ALL ON TABLE protected_sites.wdpa_centroids TO h05mandand;
GRANT ALL ON TABLE protected_sites.wdpa_centroids TO d6biopama;
GRANT ALL ON TABLE protected_sites.wdpa_centroids TO h05ibex;
GRANT SELECT ON TABLE protected_sites.wdpa_centroids TO h05ibexro;
COMMENT ON TABLE protected_sites.wdpa_centroids IS 'last version of wdpa over 25 sqkm (points)|TRUE|CARTO';

