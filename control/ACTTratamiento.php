<?php
/**
*@package pXP
*@file gen-ACTTratamiento.php
*@author  (admin)
*@date 25-01-2017 22:44:44
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTratamiento extends ACTbase{    
			
	function listarTratamiento(){
		$this->objParam->defecto('ordenacion','id_tratamiento');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		 //$this->objParam->addFiltro("et.id_enfermedad = ".$this->objParam->getParametro('id_enfermedad')); 
		 
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTratamiento','listarTratamiento');
		} else{
			$this->objFunc=$this->create('MODTratamiento');
			
			$this->res=$this->objFunc->listarTratamiento($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTratamiento(){
		$this->objFunc=$this->create('MODTratamiento');	
		if($this->objParam->insertar('id_tratamiento')){
			$this->res=$this->objFunc->insertarTratamiento($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTratamiento($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTratamiento(){
			$this->objFunc=$this->create('MODTratamiento');	
		$this->res=$this->objFunc->eliminarTratamiento($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>