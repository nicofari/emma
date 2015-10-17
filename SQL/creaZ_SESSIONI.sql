use emma;
CREATE TABLE z_sessione
(
  id    CHAR(32) NOT NULL,
  bl_data  MEDIUMBLOB,
  ts_now     TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  INDEX (ts_now)
);


