<?php
/**
*@package pXP
*@file gen-ACTTratamientoInsumo.php
*@author  (admin)
*@date 17-02-2017 18:04:38
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTratamientoInsumo extends ACTbase{    
			
	function listarTratamientoInsumo(){
		$this->objParam->defecto('ordenacion','id_tratamiento_insumo');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_tratamiento')!=''){
			$this->objParam->addFiltro("trin.id_tratamiento = ".$this->objParam->getParametro('id_tratamiento')); 
		}
		else{
			$this->objParam->addFiltro("trin.id_tratamiento = 0"); 
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTratamientoInsumo','listarTratamientoInsumo');
		} else{
			$this->objFunc=$this->create('MODTratamientoInsumo');
			
			$this->res=$this->objFunc->listarTratamientoInsumo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTratamientoInsumo(){
		$this->objFunc=$this->create('MODTratamientoInsumo');	
		if($this->objParam->insertar('id_tratamiento_insumo')){
			$this->res=$this->objFunc->insertarTratamientoInsumo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTratamientoInsumo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTratamientoInsumo(){
			$this->objFunc=$this->create('MODTratamientoInsumo');	
		$this->res=$this->objFunc->eliminarTratamientoInsumo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>