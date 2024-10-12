<?php
include "../conexion.php";

if($_POST['rutProductora'] != "" && $_POST['nombreProductora'] != "") 
{
    $Rut_productora = $_POST['rutProductora'];
    $Nombre_productora = $_POST['nombreProductora'];

    $sql_productora = "UPDATE productora SET nombre = '".$Nombre_productora."' WHERE rut = '".$Rut_productora."'";

    $actualizacion_productora = pg_query($conexion, $sql_productora);

    if($actualizacion_productora) {
        echo "Se ha actualizado exitosamente el nombre de la productora, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar el nombre de la productora, intente nuevamente.";
    }
}
else {
    echo "No se han ingresado todos los datos requeridos, vuelva atrás y complete adecuadamente.";
}
?>