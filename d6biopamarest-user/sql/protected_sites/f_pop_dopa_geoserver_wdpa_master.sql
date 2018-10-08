-- POPULATE CENTROIDS O25 FUNCTION;
DROP FUNCTION IF EXISTS protected_sites.f_pop_dopa_geoserver_wdpa_master();
CREATE OR REPLACE FUNCTION protected_sites.f_pop_dopa_geoserver_wdpa_master()
RETURNS SETOF protected_sites.dopa_geoserver_wdpa_master
LANGUAGE 'sql' AS
$BODY$
WITH
unnested AS (
	SELECT a.wdpaid,
	unnest(string_to_array(a.iso3::text, ';'::text)) AS iso3
	FROM protected_sites.wdpa a
	WHERE a.area_geo >= 25::double precision AND a.iso3::text ~~ '%;%'::text
),
renested AS (
	SELECT
	a.wdpaid,
	array_to_string(array_agg(a.iso3), '|'::text) AS iso3,
	array_to_string(array_agg(b.iso2), '|'::text) AS iso_2_code,
	array_to_string(array_agg(b.un_m49), '|'::text) AS iso3_num,
	array_to_string(array_agg(b.english_name), '|'::text) AS country
	FROM unnested a
	LEFT JOIN administrative_units.country_atts b ON a.iso3 = b.iso3::text
	GROUP BY a.wdpaid
),
originals AS (
	SELECT
	a.wdpaid,
	a.iso3::text AS iso3,
	b.iso2::text AS iso_2_code,
	b.un_m49::text AS iso3_num,
	b.english_name::text AS country
	FROM protected_sites.wdpa a
	LEFT JOIN administrative_units.country_atts b ON a.iso3::text = b.iso3::text
	WHERE a.area_geo >= 25::double precision AND a.iso3::text !~~ '%;%'::text AND a.type::text = 'Polygon'::text
),
merged AS (
	SELECT originals.wdpaid,
	originals.iso3,
	originals.iso_2_code,
	originals.iso3_num,
	originals.country
	FROM originals
	UNION
	SELECT renested.wdpaid,
	renested.iso3,
	renested.iso_2_code,
	renested.iso3_num,
	renested.country
	FROM renested
)
SELECT a.wdpaid,
a.iso3,
a.iso_2_code,
a.iso3_num,
a.country,
b.wdpa_pid,
b.name AS wdpa_name,
b.desig,
b.desig_eng,
b.desig_type,
b.status_yr,
b.status,
b.iucn_cat,
b.gov_type,
b.own_type,
b.marine,
round(b.rep_m_area::numeric, 1) AS rep_m_area,
round(b.area_geo::numeric, 1) AS jrc_gis_area_km2,
b.mang_auth,
b.verif,
round(b.rep_area::numeric, 1) AS rep_area,
b.geom
FROM merged a
LEFT JOIN protected_sites.wdpa b ON a.wdpaid = b.wdpaid
ORDER BY a.wdpaid;
$BODY$;
GRANT EXECUTE ON FUNCTION protected_sites.f_pop_dopa_geoserver_wdpa_master() TO h05mandand;
GRANT EXECUTE ON FUNCTION protected_sites.f_pop_dopa_geoserver_wdpa_master() TO d6biopama;
GRANT EXECUTE ON FUNCTION protected_sites.f_pop_dopa_geoserver_wdpa_master() TO h05ibexro;
GRANT EXECUTE ON FUNCTION protected_sites.f_pop_dopa_geoserver_wdpa_master() TO h05ibex;
COMMENT ON FUNCTION protected_sites.f_pop_dopa_geoserver_wdpa_master() IS 'populate last version of wdpa over 25 sqkm (poly)|FALSE|';