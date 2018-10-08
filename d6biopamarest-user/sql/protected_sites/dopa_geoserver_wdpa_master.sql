DROP TABLE IF EXISTS protected_sites.dopa_geoserver_wdpa_master CASCADE;
CREATE TABLE protected_sites.dopa_geoserver_wdpa_master
(
    wdpaid integer,
    iso3 text COLLATE pg_catalog."default",
    iso_2_code text COLLATE pg_catalog."default",
    iso3_num text COLLATE pg_catalog."default",
    country text COLLATE pg_catalog."default",
    wdpa_pid character varying COLLATE pg_catalog."default",
    wdpa_name character varying COLLATE pg_catalog."default",
    desig character varying COLLATE pg_catalog."default",
    desig_eng character varying COLLATE pg_catalog."default",
    desig_type character varying COLLATE pg_catalog."default",
    status_yr integer,
    status character varying COLLATE pg_catalog."default",
    iucn_cat character varying COLLATE pg_catalog."default",
    gov_type character varying COLLATE pg_catalog."default",
    own_type character varying COLLATE pg_catalog."default",
    marine integer,
    rep_m_area numeric,
    jrc_gis_area_km2 numeric,
    mang_auth character varying COLLATE pg_catalog."default",
    verif character varying COLLATE pg_catalog."default",
    rep_area numeric,
    geom geometry(MultiPolygon,4326)
);

GRANT ALL ON TABLE protected_sites.dopa_geoserver_wdpa_master TO h05mandand;
GRANT ALL ON TABLE protected_sites.dopa_geoserver_wdpa_master TO d6biopama;
GRANT ALL ON TABLE protected_sites.dopa_geoserver_wdpa_master TO h05ibex;
GRANT SELECT ON TABLE protected_sites.dopa_geoserver_wdpa_master TO h05ibexro;

COMMENT ON TABLE protected_sites.dopa_geoserver_wdpa_master IS 'last version of wdpa over 25 sqkm (poly)|TRUE|GEOSERVER';

-- Index: dopa_geoserver_wdpa_master_geom_idx
CREATE INDEX dopa_geoserver_wdpa_master_geom_idx ON protected_sites.dopa_geoserver_wdpa_master USING gist(geom);

-- Index: dopa_geoserver_wdpa_master_un_m49_idx
CREATE INDEX dopa_geoserver_wdpa_master_un_m49_idx ON protected_sites.dopa_geoserver_wdpa_master USING btree(iso3_num);

-- Index: dopa_geoserver_wdpa_master_wdpaid_idx
CREATE INDEX dopa_geoserver_wdpa_master_wdpaid_idx ON protected_sites.dopa_geoserver_wdpa_master USING btree(wdpaid);