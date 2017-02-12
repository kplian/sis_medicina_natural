--------------- SQL ---------------

CREATE OR REPLACE FUNCTION mn.ft_tratamiento_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Medicina natural
 FUNCION: 		mn.ft_tratamiento_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'mn.ttratamiento'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'mn.ft_tratamiento_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'MN_TRA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		25-01-2017 22:44:44
	***********************************/

	if(p_transaccion='MN_TRA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tra.id_tratamiento,
						tra.estado_reg,
						tra.insumos,
						tra.descripcion,
						tra.fecha_reg,
						tra.usuario_ai,
						tra.id_usuario_reg,
						tra.id_usuario_ai,
						tra.id_usuario_mod,
						tra.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        et.id_enfermedad	
						from mn.ttratamiento tra
						inner join segu.tusuario usu1 on usu1.id_usuario = tra.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tra.id_usuario_mod
                        join mn.tenfermedad_tratamiento et on et.id_tratamiento = tra.id_tratamiento
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'MN_TRA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		25-01-2017 22:44:44
	***********************************/

	elsif(p_transaccion='MN_TRA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(tra.id_tratamiento)
					    from mn.ttratamiento tra
					    inner join segu.tusuario usu1 on usu1.id_usuario = tra.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tra.id_usuario_mod
                        join mn.tenfermedad_tratamiento et on et.id_tratamiento = tra.id_tratamiento
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
					
	else
					     
		raise exception 'Transaccion inexistente';
					         
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