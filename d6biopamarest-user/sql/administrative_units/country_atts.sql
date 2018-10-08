-- COUNTRY_ATTS TABLE
DROP TABLE IF EXISTS administrative_units.country_atts CASCADE;

CREATE TABLE administrative_units.country_atts AS SELECT * FROM geo.mv_country_atts;
ALTER TABLE administrative_units.country_atts ADD PRIMARY KEY (un_m49);
CREATE INDEX country_atts_iso3_idx ON administrative_units.country_atts USING btree(iso3);
COMMENT ON TABLE administrative_units.country_atts IS 'last version of country_atts|FALSE';
GRANT ALL ON TABLE administrative_units.country_atts TO h05mandand;
GRANT ALL ON TABLE administrative_units.country_atts TO d6biopama;
GRANT ALL ON TABLE administrative_units.country_atts TO h05ibex;
GRANT SELECT ON TABLE administrative_units.country_atts TO h05ibexro;
