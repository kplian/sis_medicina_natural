--------------- SQL ---------------

CREATE OR REPLACE FUNCTION mn.ft_insumo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Medicina natural
 FUNCION: 		mn.ft_insumo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'mn.tinsumo'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'mn.ft_insumo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'MN_INS_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		17-02-2017 18:13:18
	***********************************/

	if(p_transaccion='MN_INS_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						ins.id_insumo,
						ins.codigo,
						ins.nombre,
						ins.estado_reg,
						ins.id_usuario_ai,
						ins.usuario_ai,
						ins.fecha_reg,
						ins.id_usuario_reg,
						ins.fecha_mod,
						ins.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        ins.descripcion	
						from mn.tinsumo ins
						inner join segu.tusuario usu1 on usu1.id_usuario = ins.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ins.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'MN_INS_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		17-02-2017 18:13:18
	***********************************/

	elsif(p_transaccion='MN_INS_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_insumo)
					    from mn.tinsumo ins
					    inner join segu.tusuario usu1 on usu1.id_usuario = ins.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ins.id_usuario_mod
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