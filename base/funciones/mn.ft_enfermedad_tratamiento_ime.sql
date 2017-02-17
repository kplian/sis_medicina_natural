--------------- SQL ---------------

CREATE OR REPLACE FUNCTION mn.ft_enfermedad_tratamiento_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Medicina natural
 FUNCION: 		mn.ft_enfermedad_tratamiento_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'mn.tenfermedad_tratamiento'
 AUTOR: 		 (admin)
 FECHA:	        17-02-2017 14:52:07
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
	v_id_enfermedad_tratamiento	integer;
			    
BEGIN

    v_nombre_funcion = 'mn.ft_enfermedad_tratamiento_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'MN_ENTR_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-02-2017 14:52:07
	***********************************/

	if(p_transaccion='MN_ENTR_INS')then
					
        begin
        	--Sentencia de la insercion
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
			v_parametros.id_tratamiento,
			'activo',
			v_parametros._id_usuario_ai,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_enfermedad_tratamiento into v_id_enfermedad_tratamiento;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','EnfermedadTratamiento almacenado(a) con exito (id_enfermedad_tratamiento'||v_id_enfermedad_tratamiento||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_enfermedad_tratamiento',v_id_enfermedad_tratamiento::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'MN_ENTR_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-02-2017 14:52:07
	***********************************/

	elsif(p_transaccion='MN_ENTR_MOD')then

		begin
			--Sentencia de la modificacion
			update mn.tenfermedad_tratamiento set
			id_enfermedad = v_parametros.id_enfermedad,
			id_tratamiento = v_parametros.id_tratamiento,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_enfermedad_tratamiento=v_parametros.id_enfermedad_tratamiento;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','EnfermedadTratamiento modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_enfermedad_tratamiento',v_parametros.id_enfermedad_tratamiento::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'MN_ENTR_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-02-2017 14:52:07
	***********************************/

	elsif(p_transaccion='MN_ENTR_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from mn.tenfermedad_tratamiento
            where id_enfermedad_tratamiento=v_parametros.id_enfermedad_tratamiento;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','EnfermedadTratamiento eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_enfermedad_tratamiento',v_parametros.id_enfermedad_tratamiento::varchar);
              
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