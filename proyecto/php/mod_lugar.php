<?php
include "../conexion.php";

if($_POST['codigoLugar'] != "" && $_POST['nombreLugar'] != "" && $_POST['direccionLugar'] == ""
        && $_POST['coordenadasLatitud'] == "" && $_POST['coordenadasLongitud'] == "" && $_POST['ciudadLugar'] == "") 
{
    $Codigo_lugar = $_POST['codigoLugar'];
    $Nombre_lugar = $_POST['nombreLugar'];

    $sql_lugar = "UPDATE lugar SET nombre_lugar = '".$Nombre_lugar."' WHERE codigo = '".$Codigo_lugar."'";

    $actualizacion_lugar = pg_query($conexion, $sql_lugar);

    if($actualizacion_lugar) {
        echo "Se ha actualizado exitosamente la informacion del lugar, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la informacion del lugar, intente nuevamente.";
    }
}
elseif($_POST['codigoLugar'] != "" && $_POST['nombreLugar'] == "" && $_POST['direccionLugar'] != ""
        && $_POST['coordenadasLatitud'] == "" && $_POST['coordenadasLongitud'] == "" && $_POST['ciudadLugar'] == "") 
{
    $Codigo_lugar = $_POST['codigoLugar'];
    $Direccion_lugar = $_POST['direccionLugar'];

    $sql_lugar = "UPDATE lugar SET direccion = '".$Direccion_lugar."' WHERE codigo = '".$Codigo_lugar."'";

    $actualizacion_lugar = pg_query($conexion, $sql_lugar);

    if($actualizacion_lugar) {
        echo "Se ha actualizado exitosamente la informacion del lugar, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la informacion del lugar, intente nuevamente.";
    }
}
elseif($_POST['codigoLugar'] != "" && $_POST['nombreLugar'] == "" && $_POST['direccionLugar'] == ""
        && $_POST['coordenadasLatitud'] != "" && $_POST['coordenadasLongitud'] == "" && $_POST['ciudadLugar'] == "") 
{
    $Codigo_lugar = $_POST['codigoLugar'];
    $Coordenadas_latitud = $_POST['coordenadasLatitud'];

    $sql_lugar = "UPDATE lugar SET coordenadas_geograficas_latitud = '".$Coordenadas_latitud."' WHERE codigo = '".$Codigo_lugar."'";

    $actualizacion_lugar = pg_query($conexion, $sql_lugar);

    if($actualizacion_lugar) {
        echo "Se ha actualizado exitosamente la informacion del lugar, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la informacion del lugar, intente nuevamente.";
    }
}
elseif($_POST['codigoLugar'] != "" && $_POST['nombreLugar'] == "" && $_POST['direccionLugar'] == ""
        && $_POST['coordenadasLatitud'] == "" && $_POST['coordenadasLongitud'] != "" && $_POST['ciudadLugar'] == "") 
{
    $Codigo_lugar = $_POST['codigoLugar'];
    $Coordenadas_longitud = $_POST['coordenadasLongitud'];

    $sql_lugar = "UPDATE lugar SET coordenadas_geograficas_longitud = '".$Coordenadas_longitud."' WHERE codigo = '".$Codigo_lugar."'";

    $actualizacion_lugar = pg_query($conexion, $sql_lugar);

    if($actualizacion_lugar) {
        echo "Se ha actualizado exitosamente la informacion del lugar, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la informacion del lugar, intente nuevamente.";
    }
}
elseif($_POST['codigoLugar'] != "" && $_POST['nombreLugar'] == "" && $_POST['direccionLugar'] == ""
        && $_POST['coordenadasLatitud'] == "" && $_POST['coordenadasLongitud'] == "" && $_POST['ciudadLugar'] != "") 
{
    $Codigo_lugar = $_POST['codigoLugar'];
    $Ciudad_lugar = $_POST['ciudadLugar'];

    $sql_lugar = "UPDATE lugar SET ciudad = '".$Ciudad_lugar."' WHERE codigo = '".$Codigo_lugar."'";

    $actualizacion_lugar = pg_query($conexion, $sql_lugar);

    if($actualizacion_lugar) {
        echo "Se ha actualizado exitosamente la informacion del lugar, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la informacion del lugar, intente nuevamente.";
    }
}
else {
    echo "No se han ingresado todos los datos requeridos, vuelva atrás y complete adecuadamente.";
}
?>