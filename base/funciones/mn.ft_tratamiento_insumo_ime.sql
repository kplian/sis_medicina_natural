--------------- SQL ---------------

CREATE OR REPLACE FUNCTION mn.ft_tratamiento_insumo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Medicina natural
 FUNCION: 		mn.ft_tratamiento_insumo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'mn.ttratamiento_insumo'
 AUTOR: 		 (admin)
 FECHA:	        17-02-2017 18:04:38
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
	v_id_tratamiento_insumo	integer;
			    
BEGIN

    v_nombre_funcion = 'mn.ft_tratamiento_insumo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'MN_TRIN_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-02-2017 18:04:38
	***********************************/

	if(p_transaccion='MN_TRIN_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into mn.ttratamiento_insumo(
			id_tratamiento,
			id_insumo,
			estado_reg,
			id_usuario_ai,
			id_usuario_reg,
			usuario_ai,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_tratamiento,
			v_parametros.id_insumo,
			'activo',
			v_parametros._id_usuario_ai,
			p_id_usuario,
			v_parametros._nombre_usuario_ai,
			now(),
			null,
			null
							
			
			
			)RETURNING id_tratamiento_insumo into v_id_tratamiento_insumo;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','TratamientoInsumo almacenado(a) con exito (id_tratamiento_insumo'||v_id_tratamiento_insumo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tratamiento_insumo',v_id_tratamiento_insumo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'MN_TRIN_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-02-2017 18:04:38
	***********************************/

	elsif(p_transaccion='MN_TRIN_MOD')then

		begin
			--Sentencia de la modificacion
			update mn.ttratamiento_insumo set
			id_tratamiento = v_parametros.id_tratamiento,
			id_insumo = v_parametros.id_insumo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_tratamiento_insumo=v_parametros.id_tratamiento_insumo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','TratamientoInsumo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tratamiento_insumo',v_parametros.id_tratamiento_insumo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'MN_TRIN_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-02-2017 18:04:38
	***********************************/

	elsif(p_transaccion='MN_TRIN_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from mn.ttratamiento_insumo
            where id_tratamiento_insumo=v_parametros.id_tratamiento_insumo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','TratamientoInsumo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tratamiento_insumo',v_parametros.id_tratamiento_insumo::varchar);
              
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