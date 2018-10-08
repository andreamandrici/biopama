-- GAUL_EEZ_DISSOLVED WDPA TABLE
DROP TABLE IF EXISTS administrative_units.gaul_eez_dissolved CASCADE;

CREATE TABLE administrative_units.gaul_eez_dissolved AS SELECT * FROM geo.mv_gaul_eez_dissolved;
ALTER TABLE administrative_units.gaul_eez_dissolved ADD PRIMARY KEY (country_id);
CREATE INDEX gaul_eez_dissolved_geom_idx ON administrative_units.gaul_eez_dissolved USING gist(geom);
COMMENT ON TABLE administrative_units.gaul_eez_dissolved IS 'last version of gaul_eez|TRUE';
GRANT ALL ON TABLE administrative_units.gaul_eez_dissolved TO h05mandand;
GRANT ALL ON TABLE administrative_units.gaul_eez_dissolved TO d6biopama;
GRANT ALL ON TABLE administrative_units.gaul_eez_dissolved TO h05ibex;
GRANT SELECT ON TABLE administrative_units.gaul_eez_dissolved TO h05ibexro;
