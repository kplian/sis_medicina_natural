<?php
/**
*@package pXP
*@file gen-MODTratamientoInsumo.php
*@author  (admin)
*@date 17-02-2017 18:04:38
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTratamientoInsumo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTratamientoInsumo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='mn.ft_tratamiento_insumo_sel';
		$this->transaccion='MN_TRIN_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tratamiento_insumo','int4');
		$this->captura('id_tratamiento','int4');
		$this->captura('id_insumo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		$this->captura('nombre','varchar');
		$this->captura('codigo','varchar');
		$this->captura('descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarTratamientoInsumo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='mn.ft_tratamiento_insumo_ime';
		$this->transaccion='MN_TRIN_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tratamiento','id_tratamiento','int4');
		$this->setParametro('id_insumo','id_insumo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTratamientoInsumo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='mn.ft_tratamiento_insumo_ime';
		$this->transaccion='MN_TRIN_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tratamiento_insumo','id_tratamiento_insumo','int4');
		$this->setParametro('id_tratamiento','id_tratamiento','int4');
		$this->setParametro('id_insumo','id_insumo','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTratamientoInsumo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='mn.ft_tratamiento_insumo_ime';
		$this->transaccion='MN_TRIN_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tratamiento_insumo','id_tratamiento_insumo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>