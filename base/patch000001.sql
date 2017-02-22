
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
  PRIMARY KEY(id_tratamiento)
) INHERITS (pxp.tbase)

WITH (oids = false);


--------------- SQL ---------------

CREATE TABLE mn.tenfermedad_tratamiento (
  id_enfermedad INTEGER,
  id_tratamiento INTEGER,
  id_enfermedad_tratamiento SERIAL NOT NULL,
  PRIMARY KEY(id_tratamiento)
) INHERITS (pxp.tbase)

WITH (oids = false);


/***********************************F-SCP-JUAN-MN-0-12/05/2017****************************************/


/***********************************I-SCP-JUAN-MN-0-11/06/2017****************************************/
--------------- SQL ---------------

CREATE TABLE mn.tinsumo (
  id_insumo SERIAL NOT NULL,
  codigo VARCHAR(500),
  nombre VARCHAR(500),
  PRIMARY KEY(id_insumos)
) INHERITS (pxp.tbase)

WITH (oids = false);

--------------- SQL ---------------

CREATE TABLE mn.ttratamiento_insumo (
  id_tratamiento_insumo SERIAL NOT NULL,
  id_tratamiento INTEGER,
  id_insumo INTEGER,
  PRIMARY KEY(id_tratamiento_insumo)
) INHERITS (pxp.tbase)

WITH (oids = false);
/***********************************F-SCP-JUAN-MN-0-11/06/2017****************************************/

/***********************************I-SCP-JUAN-MN-0-18/06/2017****************************************/

ALTER TABLE mn.ttratamiento
  ADD COLUMN nombre VARCHAR(50);
  

ALTER TABLE mn.tinsumo
  ADD COLUMN descripcion VARCHAR(500);
/***********************************F-SCP-JUAN-MN-0-18/06/2017****************************************/
