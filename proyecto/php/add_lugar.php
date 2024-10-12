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

if($_POST['nombreLugar'] != "" and $_POST['direccionLugar'] != ""
    and $_POST['coordenadasLatitud'] != "" and $_POST['coordenadasLongitud'] != "" and $_POST['ciudadLugar'] != "")
{
    $Codigo = generarNumeroAleatorio(6);
    $Nombre_lugar = $_POST['nombreLugar'];
    $Direccion = $_POST['direccionLugar'];
    $Coordenadas_geograficas_latitud = $_POST['coordenadasLatitud'];
    $Coordenadas_geograficas_longitud = $_POST['coordenadasLongitud'];
    $Ciudad = $_POST['ciudadLugar'];

    $sql_lugar = "INSERT INTO lugar VALUES (".$Codigo.",'".$Nombre_lugar."','".$Direccion."',".$Coordenadas_geograficas_latitud.",".$Coordenadas_geograficas_longitud.",'".$Ciudad."');";

    $insercion_lugar = pg_query($conexion, $sql_lugar);

    if($insercion_lugar)
    {
        echo "Se ha agregado exitosamente el lugar, su código de lugar es: <b>$Codigo</b>.";
        echo "<br>";
        echo "Vuelva atrás para continuar.";
    }
    else
    {
        echo "Se ha producido un error al agregar el lugar, intente nuevamente.";
    }
}
else
{
    echo "No se han ingresado todos los datos requeridos, vuelva atrás y complete adecuadamente.";
}
?>