-- MAIN WDPA TABLE
DROP TABLE IF EXISTS protected_sites.wdpa CASCADE;

CREATE TABLE protected_sites.wdpa AS SELECT * FROM geo.mv_wdpa;
ALTER TABLE protected_sites.wdpa ADD PRIMARY KEY (wdpaid);
CREATE INDEX wdpa_geom_idx ON protected_sites.wdpa USING gist(geom);
CREATE INDEX wdpa_iso3_idx ON protected_sites.wdpa USING btree(iso3);
CREATE INDEX wdpa_marine_idx ON protected_sites.wdpa USING btree(marine);
CREATE INDEX wdpa_wdpaid_idx ON protected_sites.wdpa USING btree(wdpaid);
COMMENT ON TABLE protected_sites.wdpa IS 'last version of wdpa (poly)|TRUE';
GRANT ALL ON TABLE protected_sites.wdpa TO h05mandand;
GRANT ALL ON TABLE protected_sites.wdpa TO d6biopama;
GRANT ALL ON TABLE protected_sites.wdpa TO h05ibex;
GRANT SELECT ON TABLE protected_sites.wdpa TO h05ibexro;
