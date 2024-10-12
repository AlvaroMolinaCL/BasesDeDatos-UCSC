<?php
include "../conexion.php";

if (isset($_REQUEST['numEntradaPresencial']) && $_REQUEST['numEntradaPresencial'] !== '') {
    $numEntradaPresencial = $_REQUEST['numEntradaPresencial'];

    $consultaExistencia = pg_query($conexion, "SELECT * FROM entrada WHERE numero_entrada=$numEntradaPresencial");

    if ($consultaExistencia) {
        if (pg_num_rows($consultaExistencia) > 0) {

            $consultaReferencias = pg_query($conexion, "SELECT * FROM entrada_presencial WHERE fk_numero_entrada=$numEntradaPresencial");

            while ($row = pg_fetch_assoc($consultaReferencias)) {
                $idReferencia = $row['fk_numero_entrada'];
                $queryEliminarReferencia = "DELETE FROM entrada_presencial WHERE fk_numero_entrada=$idReferencia";
                $resultadoEliminarReferencia = pg_query($conexion, $queryEliminarReferencia);

                if (!$resultadoEliminarReferencia) {
                    echo "Error al intentar eliminar la referencia externa con ID $idReferencia.";
                    exit;
                }
            }

            $queryEliminar = "DELETE FROM entrada WHERE numero_entrada=$numEntradaPresencial";
            $resultadoEliminar = pg_query($conexion, $queryEliminar);

            if ($resultadoEliminar) {
                echo "La entrada presencial con número $numEntradaPresencial ha sido eliminado exitosamente, junto con sus referencias externas.";
            } else {
                echo "Error al intentar eliminar la entrada presencial.";
            }
        } else {
            echo "La entrada presencial con número $numEntradaPresencial no existe.";
        }
    } else {
        echo "Error al intentar verificar la existencia de la entrada presencial.";
    }
} else {
    echo 'Debe completar los datos para realizar la búsqueda.';
}
?>
