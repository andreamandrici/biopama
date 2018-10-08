-- WDPA DRUPAL TABLE
DROP TABLE IF EXISTS protected_sites.dopa_drupal_wdpa_master CASCADE;

CREATE TABLE protected_sites.dopa_drupal_wdpa_master
(
    wdpaid integer,
    iso3 text,
    iso_2_code text,
    iso3_num text,
    country text,
    wdpa_name character varying,
    desig character varying,
    desig_type character varying,
    status_yr integer,
    iucn_cat character varying,
    marine integer,
    jrc_gis_area_km2 numeric,
    mang_auth character varying,
    rep_area numeric,
    geom text
);

GRANT ALL ON TABLE protected_sites.dopa_drupal_wdpa_master TO h05mandand;
GRANT ALL ON TABLE protected_sites.dopa_drupal_wdpa_master TO d6biopama;
GRANT ALL ON TABLE protected_sites.dopa_drupal_wdpa_master TO h05ibex;
GRANT SELECT ON TABLE protected_sites.dopa_drupal_wdpa_master TO h05ibexro;
COMMENT ON TABLE protected_sites.dopa_drupal_wdpa_master IS 'Last version of wdpa over 25 sqkm (simplified poly)|TRUE|DRUPAL';