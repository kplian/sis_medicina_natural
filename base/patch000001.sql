
/***********************************I-SCP-JUAN-MN-0-12/05/2017****************************************/
--------------- SQL ---------------
CREATE TABLE mn.tenfermedad (
  id_enfermedad SERIAL NOT NULL,
  nombre VARCHAR(50),
  sinonimos VARCHAR [],
  sintomas VARCHAR(500),
  PRIMARY KEY(id_enfermedad)
) INHERITS (pxp.tbase)

WITH (oids = false);

--------------- SQL ---------------

CREATE TABLE mn.ttratamiento (
  id_tratamiento SERIAL NOT NULL,
  descripcion VARCHAR(500),
  insumos VARCHAR(500),
  PRIMARY KEY(id_tratamiento)
) INHERITS (pxp.tbase)

WITH (oids = false);


--------------- SQL ---------------

CREATE TABLE mn.tenfermedad_tratamiento (
  id_enfermedad INTEGER,
  id_tratamiento INTEGER
) INHERITS (pxp.tbase)

WITH (oids = false);

/***********************************F-SCP-JUAN-MN-0-12/05/2017****************************************/

