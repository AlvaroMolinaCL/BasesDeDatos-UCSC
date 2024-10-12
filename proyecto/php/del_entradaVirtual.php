<?php
include "../conexion.php";

if (isset($_REQUEST['numEntradaVirtual']) && $_REQUEST['numEntradaVirtual'] !== '') {
    $numEntradaVirtual = $_REQUEST['numEntradaVirtual'];

    $consultaExistencia = pg_query($conexion, "SELECT * FROM entrada WHERE numero_entrada=$numEntradaVirtual");

    if ($consultaExistencia) {
        if (pg_num_rows($consultaExistencia) > 0) {

            $consultaReferencias = pg_query($conexion, "SELECT * FROM entrada_virtual WHERE fk_numero_entrada=$numEntradaVirtual");

            while ($row = pg_fetch_assoc($consultaReferencias)) {
                $idReferencia = $row['fk_numero_entrada']; 
                $queryEliminarReferencia = "DELETE FROM entrada_virtual WHERE fk_numero_entrada=$idReferencia";
                $resultadoEliminarReferencia = pg_query($conexion, $queryEliminarReferencia);

                if (!$resultadoEliminarReferencia) {
                    echo "Error al intentar eliminar la referencia externa con ID $idReferencia.";
                    exit;
                }
            }

            $queryEliminar = "DELETE FROM entrada WHERE numero_entrada=$numEntradaVirtual";
            $resultadoEliminar = pg_query($conexion, $queryEliminar);

            if ($resultadoEliminar) {
                echo "La entrada virtual con número $numEntradaVirtual ha sido eliminado exitosamente, junto con sus referencias externas.";
            } else {
                echo "Error al intentar eliminar la entrada virtual.";
            }
        } else {
            echo "La entrada virtual con número $numEntradaVirtual no existe.";
        }
    } else {
        echo "Error al intentar verificar la existencia de la entrada virtual.";
    }
} else {
    echo 'Debe completar los datos para realizar la búsqueda.';
}
?>
