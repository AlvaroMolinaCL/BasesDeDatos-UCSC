<?php
include "../conexion.php";

if (isset($_REQUEST['codigoReclamo']) && $_REQUEST['codigoReclamo'] !== '') {
    $codigoReclamo = $_REQUEST['codigoReclamo'];

    $consultaExistencia = pg_query($conexion, "SELECT * FROM reclamo WHERE codigo_reclamo=$codigoReclamo");

    if (pg_num_rows($consultaExistencia) > 0) {

        $queryEliminarRelacionados = "DELETE FROM tiene WHERE fk_codigo_reclamo=$codigoReclamo";
        $resultadoEliminarRelacionados = pg_query($conexion, $queryEliminarRelacionados);

        if ($resultadoEliminarRelacionados) {
            $queryEliminar = "DELETE FROM reclamo WHERE codigo_reclamo=$codigoReclamo";
            $resultadoEliminar = pg_query($conexion, $queryEliminar);

            if ($resultadoEliminar) {
                echo "El reclamo con código $codigoReclamo ha sido eliminado exitosamente.";
            } else {
                echo "Error al intentar eliminar el reclamo.";
            }
        } else {
            echo "Error al intentar eliminar los registros relacionados en la tabla tiene.";
        }
    } else {
        echo "El reclamo con código $codigoReclamo no existe.";
    }
} else {
    echo 'Debe completar los datos para realizar la búsqueda.';
}
?>
