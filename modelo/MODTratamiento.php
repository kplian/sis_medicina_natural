<?php
/**
*@package pXP
*@file gen-MODTratamiento.php
*@author  (admin)
*@date 25-01-2017 22:44:44
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODTratamiento extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarTratamiento(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='mn.ft_tratamiento_sel';
		$this->transaccion='MN_TRA_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_tratamiento','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('insumos','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('id_enfermedad','int4');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarTratamiento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='mn.ft_tratamiento_ime';
		$this->transaccion='MN_TRA_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('insumos','insumos','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		
		$this->setParametro('id_enfermedad','id_enfermedad','int4');
		

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarTratamiento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='mn.ft_tratamiento_ime';
		$this->transaccion='MN_TRA_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tratamiento','id_tratamiento','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('insumos','insumos','varchar');
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarTratamiento(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='mn.ft_tratamiento_ime';
		$this->transaccion='MN_TRA_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_tratamiento','id_tratamiento','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>