<?php
include "../conexion.php";

if (isset($_REQUEST['idEventoVirtual']) && $_REQUEST['idEventoVirtual'] !== '') {
    $idEventoVirtual = $_REQUEST['idEventoVirtual'];

    $consultaExistencia = pg_query($conexion, "SELECT * FROM evento WHERE id=$idEventoVirtual");

    if ($consultaExistencia) {
        if (pg_num_rows($consultaExistencia) > 0) {

            $consultaReferencias = pg_query($conexion, "SELECT * FROM evento_virtual WHERE fk_id=$idEventoVirtual");

            while ($row = pg_fetch_assoc($consultaReferencias)) {
                $idReferencia = $row['fk_id'];
                $queryEliminarReferencia = "DELETE FROM evento_virtual WHERE fk_id=$idReferencia";
                $resultadoEliminarReferencia = pg_query($conexion, $queryEliminarReferencia);

                if (!$resultadoEliminarReferencia) {
                    echo "Error al intentar eliminar la referencia externa con ID $idReferencia.";
                    exit;
                }
            }

            $queryEliminar = "DELETE FROM evento WHERE id=$idEventoVirtual";
            $resultadoEliminar = pg_query($conexion, $queryEliminar);

            if ($resultadoEliminar) {
                echo "El evento virtual con ID $idEventoVirtual ha sido eliminado exitosamente, junto con sus referencias externas.";
            } else {
                echo "Error al intentar eliminar el evento virtual.";
            }
        } else {
            echo "El evento virtual con ID $idEventoVirtual no existe.";
        }
    } else {
        echo "Error al intentar verificar la existencia del evento virtual.";
    }
} else {
    echo 'Debe completar los datos para realizar la búsqueda.';
}
?>
