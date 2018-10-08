-- CREATE TABLE utils.tracker

DROP TABLE IF EXISTS utils.tracker;
CREATE TABLE utils.tracker (id serial PRIMARY KEY, "role" text, "schema" text, "table" text, "date" integer);
GRANT ALL ON TABLE utils.tracker TO h05mandand;
GRANT ALL ON TABLE utils.tracker TO h05ibex;
GRANT ALL ON TABLE utils.tracker TO d6biopama;
GRANT SELECT ON TABLE utils.tracker TO h05ibexro;
GRANT ALL ON SEQUENCE utils.tracker_id_seq TO h05mandand;
GRANT ALL ON SEQUENCE utils.tracker_id_seq TO h05ibex;
GRANT ALL ON SEQUENCE utils.tracker_id_seq TO d6biopama;
GRANT SELECT ON SEQUENCE utils.tracker_id_seq TO h05ibexro;
