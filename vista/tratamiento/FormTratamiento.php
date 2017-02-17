<?php
/**
 * @package pXP
 * @file gen-SistemaDist.php
 * @author  (rarteaga)
 * @date 20-09-2011 10:22:05
 * @description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    var estadoGestion=null;
    Phx.vista.FormTratamiento = {
        //bsave: false,
        require: '../../../sis_medicina_natural/vista/tratamiento/Tratamiento.php',
        requireclase: 'Phx.vista.Tratamiento',
        title: 'Tratamientos',

        constructor: function (config) {
            this.maestro = config.maestro;
            Phx.vista.FormTratamiento.superclass.constructor.call(this, config);
            this.init();

        }

        
    };
</script>
