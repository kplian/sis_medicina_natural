--------------- SQL ---------------

CREATE OR REPLACE FUNCTION mn.ft_enfermedad_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Medicina natural
 FUNCION: 		mn.ft_enfermedad_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'mn.tenfermedad'
 AUTOR: 		 (admin)
 FECHA:	        25-01-2017 21:48:50
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_enfermedad	        integer;
    
    v_asinonimo  	        varchar[];
    
    item_id_enfermedades    INTEGER;
    enfermedades            VARCHAR [];
			    
BEGIN

    v_nombre_funcion = 'mn.ft_enfermedad_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'MN_ENF_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-01-2017 21:48:50
	***********************************/

	if(p_transaccion='MN_ENF_INS')then
	
        begin 
        
         v_asinonimo := string_to_array(v_parametros.sinonimos, ',');

        	--Sentencia de la insercion
        	insert into mn.tenfermedad(
			sintomas,
			sinonimos,
			estado_reg,
			nombre,
			id_usuario_ai,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.sintomas,
			v_asinonimo::VARCHAR[],
			'activo',
			v_parametros.nombre,
			v_parametros._id_usuario_ai,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			null,
			null

			)RETURNING id_enfermedad into v_id_enfermedad;
            
            --Insertar tabla enfermedad tratamiento
           enfermedades := string_to_array(v_parametros.id_tratamientos, ',');

            FOREACH item_id_enfermedades IN ARRAY enfermedades LOOP
              insert into mn.tenfermedad_tratamiento(
              id_enfermedad,
              id_tratamiento,
              estado_reg,
              id_usuario_ai,
              id_usuario_reg,
              fecha_reg,
              usuario_ai,
              fecha_mod,
              id_usuario_mod
              ) values(
              v_id_enfermedad,
              item_id_enfermedades :: INTEGER,
              'activo',
              v_parametros._id_usuario_ai,
              p_id_usuario,
              now(),
              v_parametros._nombre_usuario_ai,
              null,
              null
              );
            END LOOP;
            ------------------------------------------
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Enfermedad almacenado(a) con exito (id_enfermedad'||v_id_enfermedad||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_enfermedad',v_id_enfermedad::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'MN_ENF_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-01-2017 21:48:50
	***********************************/

	elsif(p_transaccion='MN_ENF_MOD')then

		begin
            v_asinonimo := string_to_array(v_parametros.sinonimos, ',');

			--Sentencia de la modificacion
			update mn.tenfermedad set
			sintomas = v_parametros.sintomas,
			sinonimos = v_asinonimo::VARCHAR[],
			nombre = v_parametros.nombre,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_enfermedad=v_parametros.id_enfermedad;
            
            --Modificar tabla enfermedad tratamiento
            delete  from mn.tenfermedad_tratamiento where id_enfermedad=v_parametros.id_enfermedad;
            enfermedades := string_to_array(v_parametros.id_tratamientos, ',');

            FOREACH item_id_enfermedades IN ARRAY enfermedades LOOP
              insert into mn.tenfermedad_tratamiento(
              id_enfermedad,
              id_tratamiento,
              estado_reg,
              id_usuario_ai,
              id_usuario_reg,
              fecha_reg,
              usuario_ai,
              fecha_mod,
              id_usuario_mod
              ) values(
              v_parametros.id_enfermedad,
              item_id_enfermedades :: INTEGER,
              'activo',
              v_parametros._id_usuario_ai,
              p_id_usuario,
              now(),
              v_parametros._nombre_usuario_ai,
              null,
              null
              );
            END LOOP;
            ------------------------------------------
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Enfermedad modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_enfermedad',v_parametros.id_enfermedad::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'MN_ENF_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-01-2017 21:48:50
	***********************************/

	elsif(p_transaccion='MN_ENF_ELI')then

		begin
			--Sentencia de la eliminacion
            
            delete  from mn.tenfermedad_tratamiento where id_enfermedad=v_parametros.id_enfermedad;
            
			delete from mn.tenfermedad
            where id_enfermedad=v_parametros.id_enfermedad;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Enfermedad eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_enfermedad',v_parametros.id_enfermedad::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;