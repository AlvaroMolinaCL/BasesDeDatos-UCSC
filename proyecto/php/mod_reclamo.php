<?php
include "../conexion.php";

if($_POST['codigoReclamo'] != "" && $_POST['rutCliente'] != "" && $_POST['descripcionReclamo'] == "" && $_POST['categoriaReclamo'] == "0") 
{
    $Codigo_reclamo = $_POST['codigoReclamo'];
    $Rut_cliente = $_POST['rutCliente'];

    $sql_reclamo = "UPDATE reclamo SET fk_rut_cliente = '".$Rut_cliente."' WHERE codigo_reclamo = '".$Codigo_reclamo."'";

    $actualizacion_reclamo = pg_query($conexion, $sql_reclamo);

    if($actualizacion_reclamo) {
        echo "Se ha actualizado exitosamente el reclamo, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar el reclamo, intente nuevamente.";
    }
}
elseif($_POST['codigoReclamo'] != "" && $_POST['rutCliente'] == "" && $_POST['descripcionReclamo'] != "" && $_POST['categoriaReclamo'] == "0") 
{
    $Codigo_reclamo = $_POST['codigoReclamo'];
    $Descripcion_reclamo = $_POST['descripcionReclamo'];

    $sql_reclamo = "UPDATE reclamo SET descripcion = '".$Descripcion_reclamo."' WHERE codigo_reclamo = '".$Codigo_reclamo."'";

    $actualizacion_reclamo = pg_query($conexion, $sql_reclamo);

    if($actualizacion_reclamo) {
        echo "Se ha actualizado exitosamente el reclamo, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar el reclamo, intente nuevamente.";
    }
}
elseif($_POST['codigoReclamo'] != "" && $_POST['rutCliente'] == "" && $_POST['descripcionReclamo'] == "" && $_POST['categoriaReclamo'] != "0") 
{
    $Codigo_reclamo = $_POST['codigoReclamo'];
    $Categoria_reclamo = $_POST['categoriaReclamo'];

    $sql_reclamo = "UPDATE reclamo SET categoria_reclamo = '".$Categoria_reclamo."' WHERE codigo_reclamo = '".$Codigo_reclamo."'";

    $actualizacion_reclamo = pg_query($conexion, $sql_reclamo);

    if($actualizacion_reclamo) {
        echo "Se ha actualizado exitosamente el reclamo, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar el reclamo, intente nuevamente.";
    }
}
else {
    echo "No se han ingresado todos los datos requeridos, vuelva atrás y complete adecuadamente.";
}

?>