--------------- SQL ---------------

CREATE OR REPLACE FUNCTION mn.ft_tratamiento_insumo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Medicina natural
 FUNCION: 		mn.ft_tratamiento_insumo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'mn.ttratamiento_insumo'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'mn.ft_tratamiento_insumo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'MN_TRIN_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		17-02-2017 18:04:38
	***********************************/

	if(p_transaccion='MN_TRIN_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						trin.id_tratamiento_insumo,
						trin.id_tratamiento,
						trin.id_insumo,
						trin.estado_reg,
						trin.id_usuario_ai,
						trin.id_usuario_reg,
						trin.usuario_ai,
						trin.fecha_reg,
						trin.id_usuario_mod,
						trin.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        i.nombre,
                        i.codigo			
						from mn.ttratamiento_insumo trin
						inner join segu.tusuario usu1 on usu1.id_usuario = trin.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = trin.id_usuario_mod
                        join mn.tinsumo i on i.id_insumo = trin.id_insumo
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'MN_TRIN_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		17-02-2017 18:04:38
	***********************************/

	elsif(p_transaccion='MN_TRIN_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_tratamiento_insumo)
					    from mn.ttratamiento_insumo trin
					    inner join segu.tusuario usu1 on usu1.id_usuario = trin.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = trin.id_usuario_mod
                        join mn.tinsumo i on i.id_insumo = trin.id_insumo
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