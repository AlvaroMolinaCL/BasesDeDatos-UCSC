<?php
include "../conexion.php";

if($_POST['rutCliente'] != "" and $_POST['nombreCliente'] != "" and $_POST['edadCliente'] != "" and $_POST['correoCliente'] != "")
{
    $RUT = $_POST['rutCliente'];
    $Nombre = $_POST['nombreCliente'];
    $Edad = $_POST['edadCliente'];
    $Correo_electronico = $_POST['correoCliente'];

    $sql_cliente = "INSERT INTO cliente VALUES (".$RUT.",'".$Nombre."',".$Edad.",'".$Correo_electronico."');";

    $insercion_cliente = pg_query($conexion, $sql_cliente);

    if($insercion_cliente)
    {
        echo "Se ha ingresado exitosamente el cliente, vuelva atrás para continuar.";
    }
    else
    {
        echo "Se ha producido un error al ingresar el cliente, intente nuevamente.";
    }
}
else
{
    echo "No se han ingresado todos los datos requeridos, vuelva atrás y complete adecuadamente.";
}
?>