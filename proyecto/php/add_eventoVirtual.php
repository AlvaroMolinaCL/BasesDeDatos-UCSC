<?php
include "../conexion.php";

function generarNumeroAleatorio($longitud) {
    $digitos = '123456789';
    $cantidadDigitos = strlen($digitos);
    $numeroAleatorio = '';

    for ($i = 0; $i < $longitud; $i++) {
        $indiceAleatorio = mt_rand(0, $cantidadDigitos - 1);
        $numeroAleatorio .= $digitos[$indiceAleatorio];
    }

    return $numeroAleatorio;
}

if($_POST['nombreEvento'] != "" and $_POST['descripcionEvento'] != "" and $_POST['fechaIniEvento'] != ""
    and $_POST['fechaTerEvento'] != "" and $_POST['horaIniEvento'] != "" and $_POST['horaTerEvento'] != ""
    and $_POST['duracionEvento'] != "" and $_POST['categoriaEvento'] != "" and $_POST['restriccion'] != ""
    and $_POST['plataformaVirtual'] != "")
{
    $id = generarNumeroAleatorio(6);
    $nombre = $_POST['nombreEvento'];
    $descripcion = $_POST['descripcionEvento'];
    $fecha_inicio = $_POST['fechaIniEvento'];
    $fecha_termino = $_POST['fechaTerEvento'];
    $hora_inicio = $_POST['horaIniEvento'];
    $hora_termino = $_POST['horaTerEvento'];
    $duracion = $_POST['duracionEvento'];
    $categoria = $_POST['categoriaEvento'];
    $restriccion = $_POST['restriccion'];

    $sql_evento = "INSERT INTO evento VALUES (".$id.",'".$nombre."','".$descripcion."',
                '".$fecha_inicio."','".$fecha_termino."','".$hora_inicio."','".$hora_termino."',
                ".$duracion.",'".$categoria."','".$restriccion."');";

    $insercion_evento = pg_query($conexion, $sql_evento);

    $fk_id = $id;
    $plataforma = $_POST['plataformaVirtual'];

    $sql_evento_virtual = "INSERT INTO evento_virtual VALUES (".$fk_id.",'".$plataforma."');";

    $insercion_evento_virtual = pg_query($conexion, $sql_evento_virtual);

    if($insercion_evento and $insercion_evento_virtual)
    {
        echo "Se ha agregado exitosamente el evento virtual, su ID de evento es: <b>$id</b>.";
        echo "<br>";
        echo "Vuelva atrás para continuar.";
    }
    else
    {
        echo "Se ha producido un error al agregar el evento virtual, intente nuevamente.";
    }
}
else
{
    echo "No se han ingresado todos los datos requeridos, vuelva atrás y complete adecuadamente.";
}
?>