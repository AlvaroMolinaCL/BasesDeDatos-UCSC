<?php
include "../conexion.php";

if (isset($_REQUEST['rutProductora']) && $_REQUEST['rutProductora'] !== '') {
    $rutProductora = $_REQUEST['rutProductora'];

    $consultaExistencia = pg_query($conexion, "SELECT * FROM productora WHERE rut=$rutProductora");

    if (pg_num_rows($consultaExistencia) > 0) {
        $queryEliminar = "DELETE FROM productora WHERE rut=$rutProductora";
        $resultadoEliminar = pg_query($conexion, $queryEliminar);

        if ($resultadoEliminar) {
            echo "La productora con rut $rutProductora ha sido eliminada exitosamente.";
        } else {
            echo "Error al intentar eliminar la productora.";
        }
    } else {
        echo "La productora con rut $rutProductora no existe.";
    }
} else {
    echo 'Debe completar los datos para realizar la búsqueda.';
}
?>
