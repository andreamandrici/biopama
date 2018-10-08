-- CREATE FOREIGN SERVER
DROP SERVER IF EXISTS d6geo2

CREATE SERVER d6geo2
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (dbname 'd6geo', host 'pgsql96-srv2.jrc.org', port '5432');

ALTER SERVER d6geo2 OWNER TO h05mandand;
GRANT USAGE ON FOREIGN SERVER d6geo2 TO h05mandand;
GRANT USAGE ON FOREIGN SERVER d6geo2 TO h05ibex;
GRANT USAGE ON FOREIGN SERVER d6geo2 TO d6biopama;

-- CREATE FOREIGN SERVER USER MAPPING
CREATE USER MAPPING FOR h05mandand
  SERVER d6geo2
  OPTIONS (user 'h05mandand', password 'xxxxx');

-- DROP/CREATE FDW HOST SCHEMA
DROP SCHEMA IF EXISTS geo2;
CREATE SCHEMA geo2 AUTHORIZATION h05mandand;

GRANT ALL ON SCHEMA geo2 TO h05mandand;
GRANT ALL ON SCHEMA geo2 TO h05ibex;
GRANT ALL ON SCHEMA geo2 TO d6biopama;
GRANT USAGE ON SCHEMA geo2 TO h05ibexro;

-- DROP FOREIGN TABLES

DROP FOREIGN TABLE IF EXISTS geo2.country_atts_last CASCADE;
DROP FOREIGN TABLE IF EXISTS geo2.gaul_eez_last CASCADE;
DROP FOREIGN TABLE IF EXISTS geo2.gaul_eez_dissolved_last CASCADE;
DROP FOREIGN TABLE IF EXISTS geo2.wdpa_last CASCADE;
DROP FOREIGN TABLE IF EXISTS geo2.ecoregions_last CASCADE;

-- IMPORT FOREIGN TABLES

IMPORT FOREIGN SCHEMA geo
LIMIT TO (
country_atts_last,
gaul_eez_last,
gaul_eez_dissolved_last,
wdpa_last,
ecoregions_last
) FROM SERVER d6geo2 INTO geo2;

-- ADD DESCRIPTIONS TO FOREIGN TABLES

COMMENT ON FOREIGN TABLE geo2.country_atts_last IS 'provides (updated from d6geo, read only by admin) attributes (iso codes,regions, country groupings, acp, eu28) to GAUL-EEZ||';
COMMENT ON FOREIGN TABLE geo2.gaul_eez_last IS 'provides (updated from d6geo, read only by admin) GAUL-EEZ geometries|GEOGRAPHIC|';
COMMENT ON FOREIGN TABLE geo2.gaul_eez_dissolved_last IS 'provides (updated from d6geo, read only by admin) GAUL-EEZ geometries dissolved; used for analysis|GEOGRAPHIC|';
COMMENT ON FOREIGN TABLE geo2.wdpa_last IS 'provides (updated from d6geo, read only by admin) WDPA geometries|GEOGRAPHIC|';
COMMENT ON FOREIGN TABLE geo2.ecoregions_last IS 'provides (updated from d6geo, read only by admin) ecoregions geometries|GEOGRAPHIC|';

-- CREATE MATERIALIZED VIEWS

-- geo2.mv_country_atts
DROP MATERIALIZED VIEW IF EXISTS geo2.mv_country_atts CASCADE;
CREATE MATERIALIZED VIEW geo2.mv_country_atts AS SELECT * FROM geo2.country_atts_last;
COMMENT ON MATERIALIZED VIEW geo2.mv_country_atts IS 'provides (read only by all) last attributes (iso codes,regions, country groupings, acp, eu28) to GAUL-EEZ||';
CREATE UNIQUE INDEX mv_country_atts_un_m49_idx ON geo2.mv_country_atts USING btree(un_m49);
GRANT ALL ON TABLE geo2.mv_country_atts TO h05mandand;
GRANT ALL ON TABLE geo2.mv_country_atts TO d6biopama;
GRANT ALL ON TABLE geo2.mv_country_atts TO h05ibex;
GRANT SELECT ON TABLE geo2.mv_country_atts TO h05ibexro;

-- geo2.mv_gaul_eez
DROP MATERIALIZED VIEW IF EXISTS geo2.mv_gaul_eez CASCADE;
CREATE MATERIALIZED VIEW geo2.mv_gaul_eez AS SELECT * FROM geo2.gaul_eez_last;
COMMENT ON MATERIALIZED VIEW geo2.mv_gaul_eez IS 'provides (read only by all) last GAUL-EEZ geometries|GEOGRAPHIC|';
CREATE UNIQUE INDEX mv_gaul_eez_iobj_idx ON geo2.mv_gaul_eez USING btree(id_object);
CREATE INDEX mv_gaul_eez_geom_idx ON geo2.mv_gaul_eez USING gist(geom);
GRANT ALL ON TABLE geo2.mv_gaul_eez TO h05mandand;
GRANT ALL ON TABLE geo2.mv_gaul_eez TO d6biopama;
GRANT ALL ON TABLE geo2.mv_gaul_eez TO h05ibex;
GRANT SELECT ON TABLE geo2.mv_gaul_eez TO h05ibexro;

-- geo2.mv_gaul_eez_dissolved
DROP MATERIALIZED VIEW IF EXISTS geo2.mv_gaul_eez_dissolved CASCADE;
CREATE MATERIALIZED VIEW geo2.mv_gaul_eez_dissolved AS SELECT * FROM geo2.gaul_eez_dissolved_last;
COMMENT ON MATERIALIZED VIEW geo2.mv_gaul_eez_dissolved IS 'provides (read only by all) last  GAUL-EEZ geometries dissolved; used for analysis|GEOGRAPHIC|';
CREATE UNIQUE INDEX mv_gaul_eez_dissolved_cid_idx ON geo2.mv_gaul_eez_dissolved USING btree(country_id);
CREATE INDEX mv_gaul_eez_dissolved_geom_idx ON geo2.mv_gaul_eez_dissolved USING gist(geom);
GRANT ALL ON TABLE geo2.mv_gaul_eez_dissolved TO h05mandand;
GRANT ALL ON TABLE geo2.mv_gaul_eez_dissolved TO d6biopama;
GRANT ALL ON TABLE geo2.mv_gaul_eez_dissolved TO h05ibex;
GRANT SELECT ON TABLE geo2.mv_gaul_eez_dissolved TO h05ibexro;

-- geo2.mv_wdpa
DROP MATERIALIZED VIEW IF EXISTS geo2.mv_wdpa CASCADE;
CREATE MATERIALIZED VIEW geo2.mv_wdpa AS SELECT * FROM geo2.wdpa_last;
COMMENT ON MATERIALIZED VIEW geo2.mv_wdpa IS 'provides (read only by all) last WDPA geometries|GEOGRAPHIC|';
CREATE UNIQUE INDEX mv_wdpa_wdpaid_idx ON geo2.mv_wdpa USING btree (wdpaid);
CREATE INDEX mv_wdpa_geom_idx ON geo2.mv_wdpa USING gist(geom);
GRANT ALL ON TABLE geo2.mv_wdpa TO h05mandand;
GRANT ALL ON TABLE geo2.mv_wdpa TO d6biopama;
GRANT ALL ON TABLE geo2.mv_wdpa TO h05ibex;
GRANT SELECT ON TABLE geo2.mv_wdpa TO h05ibexro;

-- geo2.mv_ecoregions
DROP MATERIALIZED VIEW IF EXISTS geo2.mv_ecoregions CASCADE;
CREATE MATERIALIZED VIEW geo2.mv_ecoregions AS SELECT * FROM geo2.ecoregions_last;
COMMENT ON MATERIALIZED VIEW geo2.mv_ecoregions IS 'provides (read only by all) last ecoregions geometries|GEOGRAPHIC|';
CREATE UNIQUE INDEX mv_ecoregions_flcode_idx ON geo2.mv_ecoregions USING btree(first_level_code);
CREATE INDEX mv_ecoregions_geom_idx ON geo2.mv_ecoregions USING gist(geom);
GRANT ALL ON TABLE geo2.mv_ecoregions TO h05mandand;
GRANT ALL ON TABLE geo2.mv_ecoregions TO d6biopama;
GRANT ALL ON TABLE geo2.mv_ecoregions TO h05ibex;
GRANT SELECT ON TABLE geo2.mv_ecoregions TO h05ibexro;






