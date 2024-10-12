<?php
include "../conexion.php";

if($_POST['rutCliente'] != "" && $_POST['nombreCliente'] != "" && $_POST['edad'] == "" && $_POST['correoElectronico'] == "") {
    $RUT = $_POST['rutCliente'];
    $Nombre = $_POST['nombreCliente'];

    $sql_cliente = "UPDATE cliente SET nombre = '".$Nombre."' WHERE rut = '".$RUT."'";

    $actualizacion_cliente = pg_query($conexion, $sql_cliente);

    if($actualizacion_cliente) {
        echo "Se ha actualizado exitosamente el cliente, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar el cliente, intente nuevamente.";
    }
}
elseif($_POST['rutCliente'] != "" && $_POST['nombreCliente'] == "" && $_POST['edad'] != "" && $_POST['correoElectronico'] == "") {
    $RUT = $_POST['rutCliente'];
    $Edad = $_POST['edad'];

    $sql_cliente = "UPDATE cliente SET edad = '".$Edad."' WHERE rut = '".$RUT."'";

    $actualizacion_cliente = pg_query($conexion, $sql_cliente);

    if($actualizacion_cliente) {
        echo "Se ha actualizado exitosamente el cliente, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar el cliente, intente nuevamente.";
    }
}
elseif($_POST['rutCliente'] != "" && $_POST['nombreCliente'] == "" && $_POST['edad'] == "" && $_POST['correoElectronico'] != "") {
    $RUT = $_POST['rutCliente'];
    $Correo_electronico = $_POST['correoElectronico'];

    $sql_cliente = "UPDATE cliente SET correo_electronico = '".$Correo_electronico."' WHERE rut = '".$RUT."'";

    $actualizacion_cliente = pg_query($conexion, $sql_cliente);

    if($actualizacion_cliente) {
        echo "Se ha actualizado exitosamente el cliente, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar el cliente, intente nuevamente.";
    }
} else {
    echo "No se han ingresado todos los datos requeridos, vuelva atrás y complete adecuadamente.";
}
?>