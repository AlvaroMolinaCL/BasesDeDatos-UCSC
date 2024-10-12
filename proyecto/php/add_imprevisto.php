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

if($_POST['eventoImprevisto'] != "" and $_POST['descripcionImprevisto'] != ""
    and $_POST['categoriaImprevisto'] != "")
{
    $Numero_imprevisto = generarNumeroAleatorio(6);
    $Descripcion = $_POST['descripcionImprevisto'];
    $Categoria_imprevisto = $_POST['categoriaImprevisto'];

    $sql_imprevisto = "INSERT INTO imprevisto VALUES (".$Numero_imprevisto.",'".$Descripcion."','".$Categoria_imprevisto."');";

    $insercion_imprevisto = pg_query($conexion, $sql_imprevisto);

    $FK_numero_imprevisto =$Numero_imprevisto;
    $FK_ID = $_POST['eventoImprevisto'];

    $sql_ocurre = "INSERT INTO ocurre VALUES (".$FK_numero_imprevisto.",".$FK_ID.");";

    $insercion_ocurre = pg_query($conexion, $sql_ocurre);

    if($insercion_imprevisto and $insercion_ocurre)
    {
        echo "Se ha agregado exitosamente el imprevisto, su numero de imprevisto es: <b>$Numero_imprevisto</b>.";
        echo "<br>";
        echo "Vuelva atrás para continuar.";
    }
    else
    {
        echo "Se ha producido un error al ingresar el imprevisto, intente nuevamente.";
    }
}
else
{
    echo "No se han ingresado todos los datos requeridos, vuelva atrás y complete adecuadamente.";
}
?>