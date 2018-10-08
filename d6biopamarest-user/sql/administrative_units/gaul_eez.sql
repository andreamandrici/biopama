-- GAUL_EEZ WDPA TABLE
DROP TABLE IF EXISTS administrative_units.gaul_eez CASCADE;

CREATE TABLE administrative_units.gaul_eez AS SELECT * FROM geo.mv_gaul_eez;
ALTER TABLE administrative_units.gaul_eez ADD PRIMARY KEY (id_object);
CREATE INDEX gaul_eez_geom_idx ON administrative_units.gaul_eez USING gist(geom);
COMMENT ON TABLE administrative_units.gaul_eez IS 'last version of gaul_eez|TRUE';
GRANT ALL ON TABLE administrative_units.gaul_eez TO h05mandand;
GRANT ALL ON TABLE administrative_units.gaul_eez TO d6biopama;
GRANT ALL ON TABLE administrative_units.gaul_eez TO h05ibex;
GRANT SELECT ON TABLE administrative_units.gaul_eez TO h05ibexro;
