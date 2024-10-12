<?php
include "../conexion.php";

if (isset($_REQUEST['numeroImprevisto']) && $_REQUEST['numeroImprevisto'] !== '') {
    $numeroImprevisto = $_REQUEST['numeroImprevisto'];

    $consultaExistencia = pg_query($conexion, "SELECT * FROM imprevisto WHERE numero_imprevisto=$numeroImprevisto");

    if (pg_num_rows($consultaExistencia) > 0) {
        $queryEliminarRelacionados = "DELETE FROM ocurre WHERE fk_numero_imprevisto=$numeroImprevisto";
        $resultadoEliminarRelacionados = pg_query($conexion, $queryEliminarRelacionados);

        if ($resultadoEliminarRelacionados) {
            $queryEliminar = "DELETE FROM imprevisto WHERE numero_imprevisto=$numeroImprevisto";
            $resultadoEliminar = pg_query($conexion, $queryEliminar);

            if ($resultadoEliminar) {
                echo "El imprevisto con código $numeroImprevisto ha sido eliminado exitosamente.";
            } else {
                echo "Error al intentar eliminar el imprevisto.";
            }
        } else {
            echo "Error al intentar eliminar los registros relacionados en la tabla tiene.";
        }
    } else {
        echo "El imprevisto con código $numeroImprevisto no existe.";
    }
} else {
    echo 'Debe completar los datos para realizar la búsqueda.';
}
?>
