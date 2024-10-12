<?php
include "../conexion.php";

if (isset($_REQUEST['idEventoPresencial']) && $_REQUEST['idEventoPresencial'] !== '') {
    $idEventoPresencial = $_REQUEST['idEventoPresencial'];

    $consultaExistencia = pg_query($conexion, "SELECT * FROM evento WHERE id=$idEventoPresencial");

    if ($consultaExistencia) {
        if (pg_num_rows($consultaExistencia) > 0) {

            $consultaReferencias = pg_query($conexion, "SELECT * FROM evento_presencial WHERE fk_id=$idEventoPresencial");

            while ($row = pg_fetch_assoc($consultaReferencias)) {
                $idReferencia = $row['fk_id'];
                $queryEliminarReferencia = "DELETE FROM evento_presencial WHERE fk_id=$idReferencia";
                $resultadoEliminarReferencia = pg_query($conexion, $queryEliminarReferencia);

                if (!$resultadoEliminarReferencia) {
                    echo "Error al intentar eliminar la referencia externa con ID $idReferencia.";
                    exit;
                }
            }

            $queryEliminar = "DELETE FROM evento WHERE id=$idEventoPresencial";
            $resultadoEliminar = pg_query($conexion, $queryEliminar);

            if ($resultadoEliminar) {
                echo "El evento presencial con ID $idEventoPresencial ha sido eliminado exitosamente, junto con sus referencias externas.";
            } else {
                echo "Error al intentar eliminar el evento presencial.";
            }
        } else {
            echo "El evento presencial con ID $idEventoPresencial no existe.";
        }
    } else {
        echo "Error al intentar verificar la existencia del evento presencial.";
    }
} else {
    echo 'Debe completar los datos para realizar la búsqueda.';
}
?>
