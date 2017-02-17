--------------- SQL ---------------

CREATE OR REPLACE FUNCTION mn.ft_insumo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Medicina natural
 FUNCION: 		mn.ft_insumo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'mn.tinsumo'
 AUTOR: 		 (admin)
 FECHA:	        17-02-2017 18:13:18
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
	v_id_insumo	integer;
    
			    
BEGIN

    v_nombre_funcion = 'mn.ft_insumo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'MN_INS_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Juan	
 	#FECHA:		11-06-2017 18:13:18
	***********************************/

	if(p_transaccion='MN_INS_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into mn.tinsumo(
			codigo,
			nombre,
			estado_reg,
			id_usuario_ai,
			usuario_ai,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.codigo,
			v_parametros.nombre,
			'activo',
			v_parametros._id_usuario_ai,
			v_parametros._nombre_usuario_ai,
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_insumo into v_id_insumo;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Insumo almacenado(a) con exito (id_insumo'||v_id_insumo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_insumo',v_id_insumo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'MN_INS_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-02-2017 18:13:18
	***********************************/

	elsif(p_transaccion='MN_INS_MOD')then

		begin
			--Sentencia de la modificacion
			update mn.tinsumo set
			codigo = v_parametros.codigo,
			nombre = v_parametros.nombre,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_insumo=v_parametros.id_insumo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Insumo modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_insumo',v_parametros.id_insumo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'MN_INS_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-02-2017 18:13:18
	***********************************/

	elsif(p_transaccion='MN_INS_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from mn.tinsumo
            where id_insumo=v_parametros.id_insumo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Insumo eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_insumo',v_parametros.id_insumo::varchar);
              
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