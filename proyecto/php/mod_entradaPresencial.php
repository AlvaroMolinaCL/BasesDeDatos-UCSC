<?php
include "../conexion.php";

if($_POST['numEntrada'] != "" && $_POST['fechaEntrada'] != "" && $_POST['horaEntrada'] == ""
        && $_POST['valorEntrada'] == "" && $_POST['CategoriaPublico'] == "" && $_POST['Descuento'] == "" && $_POST['rutCliente'] == "" && $_POST['numAsiento']=="") 
{
    $Numero_entrada = $_POST['numEntrada'];
    $Fecha_entrada = $_POST['fechaEntrada'];

    $sql_entrada = "UPDATE entrada SET fecha = '".$Fecha_entrada."' WHERE numero_entrada = '".$Numero_entrada."'";

    $actualizacion_entradaPresencial = pg_query($conexion, $sql_entrada);

    if($actualizacion_entradaPresencial) {
        echo "Se ha actualizado exitosamente la entrada, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la entrada, intente nuevamente.";
    }
}
elseif($_POST['numEntrada'] != "" && $_POST['fechaEntrada'] == "" && $_POST['horaEntrada'] != ""
        && $_POST['valorEntrada'] == "" && $_POST['CategoriaPublico'] == "" && $_POST['Descuento'] == "" && $_POST['rutCliente'] == "" && $_POST['numAsiento']=="") 
{
    $Numero_entrada = $_POST['numEntrada'];
    $Hora_entrada = $_POST['horaEntrada'];

    $sql_entrada = "UPDATE entrada SET hora = '".$Hora_entrada."' WHERE numero_entrada = '".$Numero_entrada."'";

    $actualizacion_entradaPresencial = pg_query($conexion, $sql_entrada);

    if($actualizacion_entradaPresencial) {
        echo "Se ha actualizado exitosamente la entrada, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la entrada, intente nuevamente.";
    }
}
elseif($_POST['numEntrada'] != "" && $_POST['fechaEntrada'] == "" && $_POST['horaEntrada'] == ""
        && $_POST['valorEntrada'] != "" && $_POST['CategoriaPublico'] == "" && $_POST['Descuento'] == "" && $_POST['rutCliente'] == "" && $_POST['numAsiento']=="") 
{
    $Numero_entrada = $_POST['numEntrada'];
    $Valor_entrada = $_POST['valorEntrada'];

    $sql_entrada = "UPDATE entrada SET valor = '".$Valor_entrada."' WHERE numero_entrada = '".$Numero_entrada."'";

    $actualizacion_entradaPresencial = pg_query($conexion, $sql_entrada);

    if($actualizacion_entradaPresencial) {
        echo "Se ha actualizado exitosamente la entrada, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la entrada, intente nuevamente.";
    }
}
elseif($_POST['numEntrada'] != "" && $_POST['fechaEntrada'] == "" && $_POST['horaEntrada'] == ""
        && $_POST['valorEntrada'] == "" && $_POST['CategoriaPublico'] != "" && $_POST['Descuento'] == "" && $_POST['rutCliente'] == "" && $_POST['numAsiento']=="") 
{
    $Numero_entrada = $_POST['numEntrada'];
    $Categoria_publico = $_POST['CategoriaPublico'];

    $sql_entrada = "UPDATE entrada SET publico = '".$Categoria_publico."' WHERE numero_entrada = '".$Numero_entrada."'";

    $actualizacion_entradaPresencial = pg_query($conexion, $sql_entrada);

    if($actualizacion_entradaPresencial) {
        echo "Se ha actualizado exitosamente la entrada, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la entrada, intente nuevamente.";
    }
}
elseif($_POST['numEntrada'] != "" && $_POST['fechaEntrada'] == "" && $_POST['horaEntrada'] == ""
        && $_POST['valorEntrada'] == "" && $_POST['CategoriaPublico'] == "" && $_POST['Descuento'] != "" && $_POST['rutCliente'] == "" && $_POST['numAsiento']=="") 
{
    if($_POST['Descuento'] == "0")
    {
        $Numero_entrada = $_POST['numEntrada'];

        $sql_entrada = "UPDATE entrada SET descuento = NULL WHERE numero_entrada = '".$Numero_entrada."'";

        $actualizacion_entradaPresencial = pg_query($conexion, $sql_entrada);

        if($actualizacion_entradaPresencial) {
            echo "Se ha actualizado exitosamente la entrada, vuelva atrás para continuar.";
        } else {
            echo "Se ha producido un error al actualizar la entrada, intente nuevamente.";
        }
    }
    else
    {
        $Numero_entrada = $_POST['numEntrada'];
        $descuento = $_POST['Descuento'];

        $sql_entrada = "UPDATE entrada SET descuento = '".$descuento."' WHERE numero_entrada = '".$Numero_entrada."'";

        $actualizacion_entradaPresencial = pg_query($conexion, $sql_entrada);

        if($actualizacion_entradaPresencial) {
            echo "Se ha actualizado exitosamente la entrada, vuelva atrás para continuar.";
        } else {
            echo "Se ha producido un error al actualizar la entrada, intente nuevamente.";
        }
    }
}
elseif($_POST['numEntrada'] != "" && $_POST['fechaEntrada'] == "" && $_POST['horaEntrada'] == ""
        && $_POST['valorEntrada'] == "" && $_POST['CategoriaPublico'] == "" && $_POST['Descuento'] == "" && $_POST['rutCliente'] != "" && $_POST['numAsiento']=="") 
{
    if($_POST['rutCliente'] == "0")
    {
        $Numero_entrada = $_POST['numEntrada'];

        $sql_entrada = "UPDATE entrada SET fk_rut_cliente = NULL WHERE numero_entrada = '".$Numero_entrada."'";

        $actualizacion_entradaPresencial = pg_query($conexion, $sql_entrada);

        if($actualizacion_entradaPresencial) {
            echo "Se ha actualizado exitosamente la entrada, vuelva atrás para continuar.";
        } else {
            echo "Se ha producido un error al actualizar la entrada, intente nuevamente.";
        }
    }
    else
    {
        $Numero_entrada = $_POST['numEntrada'];
        $Rut_cliente = $_POST['rutCliente'];

        $sql_entrada = "UPDATE entrada SET fk_rut_cliente = '".$Rut_cliente."' WHERE numero_entrada = '".$Numero_entrada."'";

        $actualizacion_entradaPresencial = pg_query($conexion, $sql_entrada);

        if($actualizacion_entradaPresencial) {
            echo "Se ha actualizado exitosamente la entrada, vuelva atrás para continuar.";
        } else {
            echo "Se ha producido un error al actualizar la entrada, intente nuevamente.";
        }
    }
}
elseif( $_POST['numEntrada'] != "" && $_POST['fechaEntrada'] == "" && $_POST['horaEntrada'] == ""
        && $_POST['valorEntrada'] == "" && $_POST['CategoriaPublico'] == "" && $_POST['Descuento'] == "" && $_POST['rutCliente'] == "" && $_POST['numAsiento']!="") 
{
    $Numero_entrada = $_POST['numEntrada'];
    $Num_asiento = $_POST['numAsiento'];

    $sql_entrada = "UPDATE entrada_presencial SET numero_asiento = '".$Num_asiento."' WHERE fk_numero_entrada = '".$Numero_entrada."'";
    $actualizacion_entradaPresencial = pg_query($conexion, $sql_entrada);

    if($actualizacion_entradaPresencial) {
        echo "Se ha actualizado exitosamente la entrada, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la entrada, intente nuevamente.";
    }
}
else {
    echo "No se han ingresado todos los datos requeridos, vuelva atrás y complete adecuadamente.";
}
?>