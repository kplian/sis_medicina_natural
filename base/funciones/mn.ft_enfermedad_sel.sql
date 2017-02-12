--------------- SQL ---------------

CREATE OR REPLACE FUNCTION mn.ft_enfermedad_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Medicina natural
 FUNCION: 		mn.ft_enfermedad_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'mn.tenfermedad'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'mn.ft_enfermedad_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'MN_ENF_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		25-01-2017 21:48:50
	***********************************/

	if(p_transaccion='MN_ENF_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						enf.id_enfermedad,
						enf.sintomas,
						array_to_string( enf.sinonimos, '','' )::varchar as sinonimos ,
						enf.estado_reg,
						enf.nombre,
						enf.id_usuario_ai,
						enf.fecha_reg,
						enf.usuario_ai,
						enf.id_usuario_reg,
						enf.id_usuario_mod,
						enf.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from mn.tenfermedad enf
						inner join segu.tusuario usu1 on usu1.id_usuario = enf.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = enf.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'MN_ENF_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		25-01-2017 21:48:50
	***********************************/

	elsif(p_transaccion='MN_ENF_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_enfermedad)
					    from mn.tenfermedad enf
					    inner join segu.tusuario usu1 on usu1.id_usuario = enf.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = enf.id_usuario_mod
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