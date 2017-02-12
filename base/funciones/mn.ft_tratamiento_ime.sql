--------------- SQL ---------------

CREATE OR REPLACE FUNCTION mn.ft_tratamiento_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Medicina natural
 FUNCION: 		mn.ft_tratamiento_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'mn.ttratamiento'
 AUTOR: 		 (admin)
 FECHA:	        25-01-2017 22:44:44
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
	v_id_tratamiento	integer;
			    
BEGIN

    v_nombre_funcion = 'mn.ft_tratamiento_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'MN_TRA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-01-2017 22:44:44
	***********************************/

	if(p_transaccion='MN_TRA_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into mn.ttratamiento(
			estado_reg,
			insumos,
			descripcion,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			id_usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.insumos,
			v_parametros.descripcion,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
			)RETURNING id_tratamiento into v_id_tratamiento;
            

            insert into mn.tenfermedad_tratamiento(id_enfermedad, id_tratamiento)  VALUES  (v_parametros.id_enfermedad,v_id_tratamiento);
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tratamiento almacenado(a) con exito (id_tratamiento'||v_id_tratamiento||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tratamiento',v_id_tratamiento::varchar);

            --Devuelve la respuesta
            
            --raise NOTICE 'variables  %',v_parametros.id_enfermedad;
            --raise exception 'error juan %',v_resp;
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'MN_TRA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-01-2017 22:44:44
	***********************************/

	elsif(p_transaccion='MN_TRA_MOD')then

		begin
			--Sentencia de la modificacion
			update mn.ttratamiento set
			insumos = v_parametros.insumos,
			descripcion = v_parametros.descripcion,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_tratamiento=v_parametros.id_tratamiento;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tratamiento modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tratamiento',v_parametros.id_tratamiento::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'MN_TRA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		25-01-2017 22:44:44
	***********************************/

	elsif(p_transaccion='MN_TRA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from mn.ttratamiento
            where id_tratamiento=v_parametros.id_tratamiento;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tratamiento eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_tratamiento',v_parametros.id_tratamiento::varchar);
              
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