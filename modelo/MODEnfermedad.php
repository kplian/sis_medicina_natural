<?php
/**
*@package pXP
*@file gen-MODEnfermedad.php
*@author  (admin)
*@date 25-01-2017 21:48:50
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODEnfermedad extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarEnfermedad(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='mn.ft_enfermedad_sel';
		$this->transaccion='MN_ENF_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_enfermedad','int4');
		$this->captura('sintomas','varchar');
		$this->captura('sinonimos','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('nombre','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarEnfermedad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='mn.ft_enfermedad_ime';
		$this->transaccion='MN_ENF_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('sintomas','sintomas','varchar');
		$this->setParametro('sinonimos','sinonimos','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarEnfermedad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='mn.ft_enfermedad_ime';
		$this->transaccion='MN_ENF_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_enfermedad','id_enfermedad','int4');
		$this->setParametro('sintomas','sintomas','varchar');
		$this->setParametro('sinonimos','sinonimos','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('nombre','nombre','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarEnfermedad(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='mn.ft_enfermedad_ime';
		$this->transaccion='MN_ENF_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_enfermedad','id_enfermedad','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>