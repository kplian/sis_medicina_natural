<?php
/**
*@package pXP
*@file gen-EnfermedadTratamiento.php
*@author  (admin)
*@date 17-02-2017 14:52:07
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
var v_id_enfermedad=null;
Phx.vista.EnfermedadTratamiento=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.EnfermedadTratamiento.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
		Ext.getCmp('b-new-' + this.idContenedor).hide()
	},
    onReloadPage: function (m) {     
           this.maestro = m;
           
           v_id_enfermedad=this.maestro.id_enfermedad;
           this.store.baseParams = {id_enfermedad: this.maestro.id_enfermedad};
           this.load({params: {start: 0, limit: 50}})
           Ext.getCmp('b-new-' + this.idContenedor).show()
    },
	/*loadValoresIniciales: function () {
	    	//detalle
           Phx.vista.EnfermedadTratamiento.superclass.loadValoresIniciales.call(this);
            //
           this.Cmp.id_enfermedad.setValue(this.maestro.id_enfermedad);

   },	 */
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_enfermedad_tratamiento'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_enfermedad'
			},
			type:'Field',
			form:true 
		},
		/*{
			config: {
				name: 'id_enfermedad',
				fieldLabel: 'Enfermedad',
				allowBlank: true,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_medicina_natural/control/Enfermedad/listarEnfermedad',
					id: 'id_enfermedad',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_enfermedad', 'nombre'],
					remoteSort: true,
					baseParams: {par_filtro: 'enf.nombre'}
				}),
				valueField: 'id_enfermedad',
				displayField: 'nombre',
				gdisplayField: 'nombre',
				hiddenName: 'id_enfermedad',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '100%',
				gwidth: 150,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['nombre']);
				}
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'enf.nombre',type: 'string'},
			grid: true,
			form: true
		},*/
		{
			config: {
				name: 'id_tratamiento',
				fieldLabel: 'Tratamiento',
				allowBlank: true,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_medicina_natural/control/Tratamiento/listarTratamiento',
					id: 'id_tratamiento',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_tratamiento', 'nombre'],
					remoteSort: true,
					baseParams: {par_filtro: 'tra.nombre'}
				}),
				valueField: 'id_tratamiento',
				displayField: 'nombre',
				gdisplayField: 'nombre',
				hiddenName: 'id_tratamiento',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '80%',
				gwidth: 150,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['nombre']);
				}
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'tra.nombre',type: 'string'},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
				type:'TextField',
				filters:{pfiltro:'entr.estado_reg',type:'string'},
				id_grupo:1,
				grid:false,
				form:false
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: '',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'entr.id_usuario_ai',type:'numeric'},
				id_grupo:1,
				grid:false,
				form:false
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'usu1.cuenta',type:'string'},
				id_grupo:1,
				grid:false,
				form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'entr.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'usuario_ai',
				fieldLabel: 'Funcionaro AI',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:300
			},
				type:'TextField',
				filters:{pfiltro:'entr.usuario_ai',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'entr.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'usu2.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'EnfermedadTratamiento',
	ActSave:'../../sis_medicina_natural/control/EnfermedadTratamiento/insertarEnfermedadTratamiento',
	ActDel:'../../sis_medicina_natural/control/EnfermedadTratamiento/eliminarEnfermedadTratamiento',
	ActList:'../../sis_medicina_natural/control/EnfermedadTratamiento/listarEnfermedadTratamiento',
	id_store:'id_enfermedad_tratamiento',
	fields: [
		{name:'id_enfermedad_tratamiento', type: 'numeric'},
		{name:'id_enfermedad', type: 'numeric'},
		{name:'id_tratamiento', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usuario_ai', type: 'string'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		//{name:'descripcion', type: 'string'},
		{name:'nombre', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_enfermedad_tratamiento',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,
    onButtonNew: function () {
	            Phx.vista.EnfermedadTratamiento.superclass.onButtonNew.call(this);
			    this.Cmp.id_enfermedad.setValue(v_id_enfermedad);
			    

       },
	}
)
</script>
		
		