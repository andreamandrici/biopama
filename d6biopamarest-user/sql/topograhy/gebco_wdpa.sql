-- CREATE TABLE topography.gebco_wdpa
DROP TABLE IF EXISTS topography.gebco_wdpa;
CREATE TABLE topography.gebco_wdpa (
wdpaid integer,
non_null_cells integer,
null_cells bigint,
min double precision,
max double precision,
range double precision,
mean double precision,
mean_of_abs double precision,
stddev double precision,
variance double precision,
coeff_var double precision,
sum numeric(20,4),
sum_abs numeric(20,4),
first_quart double precision,
median double precision,
third_quart double precision,
perc_90 double precision
);

GRANT ALL ON TABLE topography.gebco_wdpa TO h05mandand;
GRANT ALL ON TABLE topography.gebco_wdpa TO d6biopama;
GRANT ALL ON TABLE topography.gebco_wdpa TO h05ibex;
GRANT SELECT ON TABLE topography.gebco_wdpa TO h05ibexro;

-- CREATE FUNCTION topography.gebco_wdpa
