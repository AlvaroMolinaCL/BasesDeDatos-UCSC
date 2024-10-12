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

if (
    $_POST['nombreEvento'] != "" and $_POST['descripcionEvento'] != "" and $_POST['fechaIniEvento'] != ""
    and $_POST['fechaTerEvento'] != "" and $_POST['horaIniEvento'] != "" and $_POST['horaTerEvento'] != ""
    and $_POST['duracionEvento'] != "" and $_POST['categoriaEvento'] != "" and $_POST['restriccion'] != ""
    and $_POST['codLugarEvento'] != ""
) {
    $ID = generarNumeroAleatorio(6);
    $Nombre = $_POST['nombreEvento'];
    $Descripcion = $_POST['descripcionEvento'];
    $Fecha_inicio = $_POST['fechaIniEvento'];
    $Fecha_termino = $_POST['fechaTerEvento'];
    $Hora_inicio = $_POST['horaIniEvento'];
    $Hora_termino = $_POST['horaTerEvento'];
    $Duracion = $_POST['duracionEvento'];
    $Categoria = $_POST['categoriaEvento'];
    $Restriccion = $_POST['restriccion'];

    $sql_evento = "INSERT INTO evento VALUES (" . $ID . ",'" . $Nombre . "','" . $Descripcion . "','" . $Fecha_inicio . "','" . $Fecha_termino . "','" . $Hora_inicio . "','" . $Hora_termino . "'," . $Duracion . ",'" . $Categoria . "','" . $Restriccion . "');";

    $insercion_evento = pg_query($conexion, $sql_evento);

    $FK_ID = $ID;
    $fk_codigo_lugar = $_POST['codLugarEvento'];

    $sql_evento_presencial = "INSERT INTO evento_presencial VALUES (" . $FK_ID . "," . $fk_codigo_lugar . ");";

    $insercion_evento_presencial = pg_query($conexion, $sql_evento_presencial);

    if ($insercion_evento and $insercion_evento_presencial) {
        echo "Se ha agregado exitosamente el evento presencial, su ID de evento es: <b>$ID</b>.";
        echo "<br>";
        echo "Vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al agregar el evento presencial, intente nuevamente.";
    }
} else {
    echo "No se han ingresado todos los datos requeridos, vuelva atrás y complete adecuadamente.";
}
?>
