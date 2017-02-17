<?php
/**
*@package pXP
*@file gen-ACTInsumo.php
*@author  (admin)
*@date 17-02-2017 18:13:18
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTInsumo extends ACTbase{    
			
	function listarInsumo(){
		$this->objParam->defecto('ordenacion','id_insumo');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODInsumo','listarInsumo');
		} else{
			$this->objFunc=$this->create('MODInsumo');
			
			$this->res=$this->objFunc->listarInsumo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarInsumo(){
		$this->objFunc=$this->create('MODInsumo');	
		if($this->objParam->insertar('id_insumo')){
			$this->res=$this->objFunc->insertarInsumo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarInsumo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarInsumo(){
			$this->objFunc=$this->create('MODInsumo');	
		$this->res=$this->objFunc->eliminarInsumo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>