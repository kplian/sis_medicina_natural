<?php
/**
*@package pXP
*@file gen-ACTEnfermedadTratamiento.php
*@author  (admin)
*@date 17-02-2017 14:52:07
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTEnfermedadTratamiento extends ACTbase{    
			
	function listarEnfermedadTratamiento(){
		$this->objParam->defecto('ordenacion','id_enfermedad_tratamiento');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		
		if($this->objParam->getParametro('id_enfermedad')!=''){
			$this->objParam->addFiltro("entr.id_enfermedad = ".$this->objParam->getParametro('id_enfermedad')); 
		}
		else{
			$this->objParam->addFiltro("entr.id_enfermedad = 0"); 
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODEnfermedadTratamiento','listarEnfermedadTratamiento');
		} else{
			$this->objFunc=$this->create('MODEnfermedadTratamiento');
			
			$this->res=$this->objFunc->listarEnfermedadTratamiento($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarEnfermedadTratamiento(){
		$this->objFunc=$this->create('MODEnfermedadTratamiento');	
		if($this->objParam->insertar('id_enfermedad_tratamiento')){
			$this->res=$this->objFunc->insertarEnfermedadTratamiento($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarEnfermedadTratamiento($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarEnfermedadTratamiento(){
			$this->objFunc=$this->create('MODEnfermedadTratamiento');	
		$this->res=$this->objFunc->eliminarEnfermedadTratamiento($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>