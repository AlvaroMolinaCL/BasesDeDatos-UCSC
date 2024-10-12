<?php
include "../conexion.php";

if($_POST['idEvento'] != "" && $_POST['nombreEvento'] != "" && $_POST['descripcionEvento'] == ""
        && $_POST['fechaIniEvento'] == "" && $_POST['fechaTerEvento'] == "" && $_POST['horaIniEvento'] == "" && $_POST['horaTerEvento'] == "" 
        && $_POST['duracionEvento'] == "" && $_POST['categoriaEvento']== "0" && $_POST['restriccion'] == "0" && $_POST['plataforma'] == "0") 
{
    $Id_evento = $_POST['idEvento'];
    $Nombre_evento = $_POST['nombreEvento'];

    $sql_evento = "UPDATE evento SET nombre = '".$Nombre_evento."' WHERE id = '".$Id_evento."'";

    $actualizacion_eventoPresencial = pg_query($conexion, $sql_evento);

    if($actualizacion_eventoPresencial) {
        echo "Se ha actualizado exitosamente la informacion del evento, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la informacion del evento, intente nuevamente.";
    }
}
elseif($_POST['idEvento'] != "" && $_POST['nombreEvento'] == "" && $_POST['descripcionEvento'] != ""
        && $_POST['fechaIniEvento'] == "" && $_POST['fechaTerEvento'] == "" && $_POST['horaIniEvento'] == "" && $_POST['horaTerEvento'] == ""
        && $_POST['duracionEvento'] == "" && $_POST['categoriaEvento']== "0" && $_POST['restriccion'] == "0" && $_POST['plataforma'] == "0")
{
    $Id_evento = $_POST['idEvento'];
    $Desc_evento = $_POST['descripcionEvento'];

    $sql_evento = "UPDATE evento SET descripcion = '".$Desc_evento."' WHERE id = '".$Id_evento."'";

    $actualizacion_eventoPresencial = pg_query($conexion, $sql_evento);

    if($actualizacion_eventoPresencial) {
        echo "Se ha actualizado exitosamente la informacion del evento, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la informacion del evento, intente nuevamente.";
    }
}
elseif($_POST['idEvento'] != "" && $_POST['nombreEvento'] == "" && $_POST['descripcionEvento'] == ""
        && $_POST['fechaIniEvento'] != "" && $_POST['fechaTerEvento'] == "" && $_POST['horaIniEvento'] == "" && $_POST['horaTerEvento'] == ""
        && $_POST['duracionEvento'] == "" && $_POST['categoriaEvento']== "0" && $_POST['restriccion'] == "0" && $_POST['plataforma'] == "0")
{
    $Id_evento = $_POST['idEvento'];
    $Fecha_ini_evento = $_POST['fechaIniEvento'];

    $sql_evento = "UPDATE evento SET fecha_inicio = '".$Fecha_ini_evento."' WHERE id = '".$Id_evento."'";

    $actualizacion_eventoPresencial = pg_query($conexion, $sql_evento);

    if($actualizacion_eventoPresencial) {
        echo "Se ha actualizado exitosamente la informacion del evento, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la informacion del evento, intente nuevamente.";
    }
}
elseif($_POST['idEvento'] != "" && $_POST['nombreEvento'] == "" && $_POST['descripcionEvento'] == ""
        && $_POST['fechaIniEvento'] == "" && $_POST['fechaTerEvento'] != "" && $_POST['horaIniEvento'] == "" && $_POST['horaTerEvento'] == ""
        && $_POST['duracionEvento'] == "" && $_POST['categoriaEvento']== "0" && $_POST['restriccion'] == "0" && $_POST['plataforma'] == "0")
{
    $Id_evento = $_POST['idEvento'];
    $Fecha_ter_evento = $_POST['fechaTerEvento'];

    $sql_evento = "UPDATE evento SET fecha_termino = '".$Fecha_ter_evento."' WHERE id = '".$Id_evento."'";

    $actualizacion_eventoPresencial = pg_query($conexion, $sql_evento);

    if($actualizacion_eventoPresencial) {
        echo "Se ha actualizado exitosamente la informacion del evento, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la informacion del evento, intente nuevamente.";
    }
}
elseif($_POST['idEvento'] != "" && $_POST['nombreEvento'] == "" && $_POST['descripcionEvento'] == ""
        && $_POST['fechaIniEvento'] == "" && $_POST['fechaTerEvento'] == "" && $_POST['horaIniEvento'] != "" && $_POST['horaTerEvento'] == "" 
        && $_POST['duracionEvento'] == "" && $_POST['categoriaEvento']== "0" && $_POST['restriccion'] == "0" && $_POST['plataforma'] == "0")
{
    $Id_evento = $_POST['idEvento'];
    $Hora_ini_evento = $_POST['horaIniEvento'];

    $sql_evento = "UPDATE evento SET hora_inicio = '".$Hora_ini_evento."' WHERE id = '".$Id_evento."'";

    $actualizacion_eventoPresencial = pg_query($conexion, $sql_evento);

    if($actualizacion_eventoPresencial) {
        echo "Se ha actualizado exitosamente la informacion del evento, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la informacion del evento, intente nuevamente.";
    }
}
elseif($_POST['idEvento'] != "" && $_POST['nombreEvento'] == "" && $_POST['descripcionEvento'] == ""
        && $_POST['fechaIniEvento'] == "" && $_POST['fechaTerEvento'] == "" && $_POST['horaIniEvento'] == "" && $_POST['horaTerEvento'] != ""
        && $_POST['duracionEvento'] == "" && $_POST['categoriaEvento']== "0" && $_POST['restriccion'] == "0" && $_POST['plataforma'] == "0")
{
    $Id_evento = $_POST['idEvento'];
    $Hora_ter_evento = $_POST['horaTerEvento'];

    $sql_evento = "UPDATE evento SET hora_termino = '".$Hora_ter_evento."' WHERE id = '".$Id_evento."'";

    $actualizacion_eventoPresencial = pg_query($conexion, $sql_evento);

    if($actualizacion_eventoPresencial) {
        echo "Se ha actualizado exitosamente la informacion del evento, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la informacion del evento, intente nuevamente.";
    }
}
elseif($_POST['idEvento'] != "" && $_POST['nombreEvento'] == "" && $_POST['descripcionEvento'] == ""
        && $_POST['fechaIniEvento'] == "" && $_POST['fechaTerEvento'] == "" && $_POST['horaIniEvento'] == "" && $_POST['horaTerEvento'] == ""
        && $_POST['duracionEvento'] != "" && $_POST['categoriaEvento']== "0" && $_POST['restriccion'] == "0" && $_POST['plataforma'] == "0")
{
    $Id_evento = $_POST['idEvento'];
    $Duracion_evento = $_POST['duracionEvento'];

    $sql_evento = "UPDATE evento SET duracion = '".$Duracion_evento."' WHERE id = '".$Id_evento."'";

    $actualizacion_eventoPresencial = pg_query($conexion, $sql_evento);

    if($actualizacion_eventoPresencial) {
        echo "Se ha actualizado exitosamente la informacion del evento, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la informacion del evento, intente nuevamente.";
    }
}
elseif($_POST['idEvento'] != "" && $_POST['nombreEvento'] == "" && $_POST['descripcionEvento'] == ""
        && $_POST['fechaIniEvento'] == "" && $_POST['fechaTerEvento'] == "" && $_POST['horaIniEvento'] == "" && $_POST['horaTerEvento'] == ""
        && $_POST['duracionEvento'] == "" && $_POST['categoriaEvento']!= "0" && $_POST['restriccion'] == "0" && $_POST['plataforma'] == "0")
{
    $Id_evento = $_POST['idEvento'];
    $Categoria_evento = $_POST['categoriaEvento'];

    $sql_evento = "UPDATE evento SET categoria = '".$Categoria_evento."' WHERE id = '".$Id_evento."'";

    $actualizacion_eventoPresencial = pg_query($conexion, $sql_evento);

    if($actualizacion_eventoPresencial) {
        echo "Se ha actualizado exitosamente la informacion del evento, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la informacion del evento, intente nuevamente.";
    }
}
elseif($_POST['idEvento'] != "" && $_POST['nombreEvento'] == "" && $_POST['descripcionEvento'] == ""
        && $_POST['fechaIniEvento'] == "" && $_POST['fechaTerEvento'] == "" && $_POST['horaIniEvento'] == "" && $_POST['horaTerEvento'] == ""
        && $_POST['duracionEvento'] == "" && $_POST['categoriaEvento']== "0" && $_POST['restriccion'] != "0" && $_POST['plataforma'] == "0")
{
    $Id_evento = $_POST['idEvento'];
    $Restriccion = $_POST['restriccion'];

    $sql_evento = "UPDATE evento SET restriccion = '".$Restriccion."' WHERE id = '".$Id_evento."'";

    $actualizacion_eventoPresencial = pg_query($conexion, $sql_evento);

    if($actualizacion_eventoPresencial) {
        echo "Se ha actualizado exitosamente la informacion del evento, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la informacion del evento, intente nuevamente.";
    }
}
elseif($_POST['idEvento'] != "" && $_POST['nombreEvento'] == "" && $_POST['descripcionEvento'] == ""
        && $_POST['fechaIniEvento'] == "" && $_POST['fechaTerEvento'] == "" && $_POST['horaIniEvento'] == "" && $_POST['horaTerEvento'] == ""
        && $_POST['duracionEvento'] == "" && $_POST['categoriaEvento']== "0" && $_POST['restriccion'] == "0" && $_POST['plataforma'] != "0")
{
    $Id_evento = $_POST['idEvento'];
    $Plataforma = $_POST['plataforma'];

    $sql_evento = "UPDATE evento_virtual SET plataforma = '".$Plataforma."' WHERE fk_id = '".$Id_evento."'";

    $actualizacion_eventoPresencial = pg_query($conexion, $sql_evento);

    if($actualizacion_eventoPresencial) {
        echo "Se ha actualizado exitosamente la informacion del evento, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la informacion del evento, intente nuevamente.";
    }
}
else {
    echo "No se han ingresado todos los datos requeridos, vuelva atrás y complete adecuadamente.";
}
?>




