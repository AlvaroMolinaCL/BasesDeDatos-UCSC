<?php
include "../conexion.php";

if($_POST['rutProductora'] != "" and $_POST['nombreProductora'] != "")
{
    $rut = $_POST['rutProductora'];
    $nombre = $_POST['nombreProductora'];

    $sql_productora = "INSERT INTO productora VALUES (".$rut.",'".$nombre."');";

    $insercion_productora = pg_query($conexion, $sql_productora);

    if($insercion_productora)
    {
        echo "Se ha ingresado exitosamente la productora, vuelva atrás para continuar.";
    }
    else
    {
        echo "Se ha producido un error al ingresar la productora, intente nuevamente.";
    }
}
else
{
    echo "No se han ingresado todos los datos requeridos, vuelva atrás y complete adecuadamente.";
}
?>