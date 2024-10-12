<?php
include "../conexion.php";

if (isset($_REQUEST['rutCliente']) && $_REQUEST['rutCliente'] !== '') {
    $rutCliente = $_REQUEST['rutCliente'];

    $consultaExistencia = pg_query($conexion, "SELECT * FROM cliente WHERE rut=$rutCliente");

    if (pg_num_rows($consultaExistencia) > 0) {
        $queryEliminar = "DELETE FROM cliente WHERE rut=$rutCliente";
        $resultadoEliminar = pg_query($conexion, $queryEliminar);

        if ($resultadoEliminar) {
            echo "El cliente con RUT $rutCliente ha sido eliminado exitosamente.";
        } else {
            echo "Error al intentar eliminar el cliente.";
        }
    } else {
        echo "El cliente con RUT $rutCliente no existe.";
    }
} else {
    echo 'Debe completar los datos para realizar la búsqueda.';
}
?>
