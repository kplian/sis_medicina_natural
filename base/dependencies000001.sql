

/***********************************I-DEP-JUAN-MN-0-30/05/2017*****************************************/

select pxp.f_insert_testructura_gui ('mn', 'SISTEMA');
select pxp.f_insert_testructura_gui ('EN', 'mn');
select pxp.f_delete_testructura_gui ('TR', 'EN');
select pxp.f_insert_testructura_gui ('TR', 'mn');
/***********************************F-DEP-JUAN-MN-0-30/05/2017*****************************************/
/***********************************I-DEP-JUAN-MN-0-06/06/2017*****************************************/
select pxp.f_insert_testructura_gui ('mn', 'SISTEMA');
select pxp.f_insert_testructura_gui ('EN', 'mn');
select pxp.f_delete_testructura_gui ('TR', 'EN');
select pxp.f_insert_testructura_gui ('TR', 'mn');
/***********************************F-DEP-JUAN-MN-0-06/06/2017*****************************************/


/***********************************I-DEP-JUAN-MN-0-11/06/2017*****************************************/

ALTER TABLE mn.tenfermedad_tratamiento
  ADD CONSTRAINT tenfermedad_tratamiento_fk FOREIGN KEY (id_enfermedad)
    REFERENCES mn.tenfermedad(id_enfermedad)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
--------------- SQL ---------------

ALTER TABLE mn.tenfermedad_tratamiento
  ADD CONSTRAINT tenfermedad_tratamiento_fk1 FOREIGN KEY (id_tratamiento)
    REFERENCES mn.ttratamiento(id_tratamiento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
--------------- SQL ---------------

ALTER TABLE mn.ttratamiento_insumo
  ADD CONSTRAINT ttratamiento_insumo_fk FOREIGN KEY (id_tratamiento)
    REFERENCES mn.ttratamiento(id_tratamiento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
--------------- SQL ---------------

ALTER TABLE mn.ttratamiento_insumo
  ADD CONSTRAINT ttratamiento_insumo_fk1 FOREIGN KEY (id_insumo)
    REFERENCES mn.tinsumo(id_insumo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    

select pxp.f_insert_testructura_gui ('mn', 'SISTEMA');
select pxp.f_insert_testructura_gui ('EN', 'mn');
select pxp.f_delete_testructura_gui ('TR', 'EN');
select pxp.f_insert_testructura_gui ('TR', 'mn');
select pxp.f_insert_testructura_gui ('INS', 'mn');
/***********************************F-DEP-JUAN-MN-0-11/06/2017*****************************************/
