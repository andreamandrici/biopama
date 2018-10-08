-- GAUL_EEZ_DISSOLVED WDPA TABLE
DROP TABLE IF EXISTS habitats_and_biotopes.ecoregions CASCADE;

CREATE TABLE habitats_and_biotopes.ecoregions AS SELECT * FROM geo.mv_ecoregions;
ALTER TABLE habitats_and_biotopes.ecoregions ADD PRIMARY KEY (first_level_code);
CREATE INDEX ecoregions_geom_idx ON habitats_and_biotopes.ecoregions USING gist(geom);
COMMENT ON TABLE habitats_and_biotopes.ecoregions IS 'last version of gaul_eez|TRUE';
GRANT ALL ON TABLE habitats_and_biotopes.ecoregions TO h05mandand;
GRANT ALL ON TABLE habitats_and_biotopes.ecoregions TO d6biopama;
GRANT ALL ON TABLE habitats_and_biotopes.ecoregions TO h05ibex;
GRANT SELECT ON TABLE habitats_and_biotopes.ecoregions TO h05ibexro;
