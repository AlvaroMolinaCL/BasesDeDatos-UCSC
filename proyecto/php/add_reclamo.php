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

if($_POST['eventoReclamo'] != "" and $_POST['rutCliente'] != ""
    and $_POST['descripcionReclamo'] != "" and $_POST['categoriaReclamo'] != "")
{
    $Codigo_reclamo = generarNumeroAleatorio(6);
    $Descripcion = $_POST['descripcionReclamo'];
    $Categoria_reclamo = $_POST['categoriaReclamo'];
    $FK_RUT_cliente = $_POST['rutCliente'];

    $sql_reclamo = "INSERT INTO reclamo VALUES (".$Codigo_reclamo.",'".$Descripcion."','".$Categoria_reclamo."',".$FK_RUT_cliente.");";

    $insercion_reclamo = pg_query($conexion, $sql_reclamo);

    $FK_codigo_reclamo = $Codigo_reclamo;
    $FK_ID = $_POST['eventoReclamo'];

    $sql_tiene = "INSERT INTO tiene VALUES (".$FK_codigo_reclamo.",".$FK_ID.");";

    $insercion_tiene = pg_query($conexion, $sql_tiene);

    if($insercion_reclamo and $insercion_tiene)
    {
        echo "Se ha agregado exitosamente el reclamo, su código de reclamo es: <b>$Codigo_reclamo</b>.";
        echo "<br>";
        echo "Vuelva atrás para continuar.";
    }
    else
    {
        echo "Se ha producido un error al ingresar al cliente, intente nuevamente.";
    }
}
else
{
    echo "No se han ingresado todos los datos requeridos, vuelva atrás y complete adecuadamente.";
}
?>