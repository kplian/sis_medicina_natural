<?php
/**
*@package pXP
*@file gen-ACTEnfermedad.php
*@author  (admin)
*@date 25-01-2017 21:48:50
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTEnfermedad extends ACTbase{    
			
	function listarEnfermedad(){
		$this->objParam->defecto('ordenacion','id_enfermedad');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODEnfermedad','listarEnfermedad');
		} else{
			$this->objFunc=$this->create('MODEnfermedad');
			
			$this->res=$this->objFunc->listarEnfermedad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarEnfermedad(){
		$this->objFunc=$this->create('MODEnfermedad');	
		if($this->objParam->insertar('id_enfermedad')){
			$this->res=$this->objFunc->insertarEnfermedad($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarEnfermedad($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarEnfermedad(){
			$this->objFunc=$this->create('MODEnfermedad');	
		$this->res=$this->objFunc->eliminarEnfermedad($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>