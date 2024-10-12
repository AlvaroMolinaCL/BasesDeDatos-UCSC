<?php
include "../conexion.php";

if (isset($_REQUEST['codigoLugar']) && $_REQUEST['codigoLugar'] !== '') {
    $codigoLugar = $_REQUEST['codigoLugar'];

    $consultaExistencia = pg_query($conexion, "SELECT * FROM lugar WHERE codigo=$codigoLugar");

    if (pg_num_rows($consultaExistencia) > 0) {
        $queryEliminar = "DELETE FROM lugar WHERE codigo=$codigoLugar";
        $resultadoEliminar = pg_query($conexion, $queryEliminar);

        if ($resultadoEliminar) {
            echo "El lugar con código $codigoLugar ha sido eliminado exitosamente.";
        } else {
            echo "Error al intentar eliminar el lugar.";
        }
    } else {
        echo "El lugar con código $codigoLugar no existe.";
    }
} else {
    echo 'Debe completar los datos para realizar la búsqueda.';
}
?>
