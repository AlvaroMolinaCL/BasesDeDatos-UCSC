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

if($_POST['fechaEntrada'] != "" and $_POST['Hora'] != "" and $_POST['valorEntrada'] != ""
    and $_POST['categoriaPublico'] != "" and $_POST['Descuento'] == "" and $_POST['rutCliente'] == ""
    and $_POST['idEventoPresencial'] != "" and $_POST['numAsiento'] != "")
{
    $Numero_entrada = generarNumeroAleatorio(6);
    $Fecha = $_POST['fechaEntrada'];
    $Hora = $_POST['Hora'];
    $Valor = $_POST['valorEntrada'];
    $Publico = $_POST['categoriaPublico'];

    $sql_entrada = "INSERT INTO entrada VALUES (".$Numero_entrada.",'".$Fecha."','".$Hora."',".$Valor.",'".$Publico."');";

    $insercion_entrada = pg_query($conexion, $sql_entrada);

    $FK_Numero_entrada = $Numero_entrada;
    $FK_ID_evento_presencial = $_POST['idEventoPresencial'];
    $Numero_asiento = $_POST['numAsiento'];

    $sql_entrada_presencial = "INSERT INTO entrada_presencial VALUES (".$FK_Numero_entrada.",".$FK_ID_evento_presencial.",".$Numero_asiento.");";

    $insercion_entrada_presencial = pg_query($conexion, $sql_entrada_presencial);

    if($insercion_entrada and $insercion_entrada_presencial)
    {
        echo "Se ha agregado exitosamente la entrada presencial, su numero de entrada es: <b>$Numero_entrada</b>.";
        echo "<br>";
        echo "Vuelva atrás para continuar.";
    }
    else
    {
        echo "Se ha producido un error al agregar la entrada presencial, intente nuevamente.";
    }
}
elseif($_POST['fechaEntrada'] != "" and $_POST['Hora'] != "" and $_POST['valorEntrada'] != ""
and $_POST['categoriaPublico'] != "" and $_POST['Descuento'] != "" and $_POST['rutCliente'] == ""
and $_POST['idEventoPresencial'] != "" and $_POST['numAsiento'] != "")
{
    $Numero_entrada =generarNumeroAleatorio(6);
    $Fecha = $_POST['fechaEntrada'];
    $Hora = $_POST['Hora'];
    $Valor = $_POST['valorEntrada'];
    $Publico = $_POST['categoriaPublico'];
    $Descuento = $_POST['Descuento'];

    $sql_entrada = "INSERT INTO entrada VALUES (".$Numero_entrada.",'".$Fecha."','".$Hora."',".$Valor.",'".$Publico."',".$Descuento.");";

    $insercion_entrada = pg_query($conexion, $sql_entrada);

    $FK_Numero_entrada =$Numero_entrada;
    $FK_ID_evento_presencial = $_POST['idEventoPresencial'];
    $Numero_asiento = $_POST['numAsiento'];

    $sql_entrada_presencial = "INSERT INTO entrada_presencial VALUES (".$FK_Numero_entrada.",".$FK_ID_evento_presencial.",".$Numero_asiento.");";

    $insercion_entrada_presencial = pg_query($conexion, $sql_entrada_presencial);

    if($insercion_entrada and $insercion_entrada_presencial)
    {
        echo "Se ha agregado exitosamente la entrada presencial, su numero de entrada es: <b>$Numero_entrada</b>.";
        echo "<br>";
        echo "Vuelva atrás para continuar.";
    }
    else
    {
        echo "\nSe ha producido un error al agregar la entrada presencial, intente nuevamente.";
    }
}
elseif($_POST['fechaEntrada'] != "" and $_POST['Hora'] != "" and $_POST['valorEntrada'] != ""
and $_POST['categoriaPublico'] != "" and $_POST['Descuento'] == "" and $_POST['rutCliente'] != ""
and $_POST['idEventoPresencial'] != "" and $_POST['numAsiento'] != "")
{
    $Numero_entrada =generarNumeroAleatorio(6);
    $Fecha = $_POST['fechaEntrada'];
    $Hora = $_POST['Hora'];
    $Valor = $_POST['valorEntrada'];
    $Publico = $_POST['categoriaPublico'];
    $FK_RUT_cliente = $_POST['rutCliente'];

    $sql_entrada = "INSERT INTO entrada VALUES (".$Numero_entrada.",'".$Fecha."','".$Hora."',".$Valor.",'".$Publico."',".$FK_RUT_cliente.");";

    $insercion_entrada = pg_query($conexion, $sql_entrada);

    $FK_Numero_entrada = $Numero_entrada;
    $FK_ID_evento_presencial = $_POST['idEventoPresencial'];
    $Numero_asiento = $_POST['numAsiento'];

    $sql_entrada_presencial = "INSERT INTO entrada_presencial VALUES (".$FK_Numero_entrada.",".$FK_ID_evento_presencial.",".$Numero_asiento.");";

    $insercion_entrada_presencial = pg_query($conexion, $sql_entrada_presencial);

    if($insercion_entrada and $insercion_entrada_presencial)
    {
        echo "Se ha agregado exitosamente la entrada presencial, su numero de entrada es: <b>$Numero_entrada</b>.";
        echo "<br>";
        echo "Vuelva atrás para continuar.";
    }
    else
    {
        echo "\nSe ha producido un error al agregar la entrada presencial, intente nuevamente.";
    }
}
elseif($_POST['fechaEntrada'] != "" and $_POST['Hora'] != "" and $_POST['valorEntrada'] != ""
and $_POST['categoriaPublico'] != "" and $_POST['Descuento'] != "" and $_POST['rutCliente'] != ""
and $_POST['idEventoPresencial'] != "" and $_POST['numAsiento'] != "")
{
    $Numero_entrada = generarNumeroAleatorio(6);
    $Fecha = $_POST['fechaEntrada'];
    $Hora = $_POST['Hora'];
    $Valor = $_POST['valorEntrada'];
    $Publico = $_POST['categoriaPublico'];
    $Descuento = $_POST['Descuento'];
    $FK_RUT_cliente = $_POST['rutCliente'];

    $sql_entrada = "INSERT INTO entrada VALUES (".$Numero_entrada.",'".$Fecha."','".$Hora."',".$Valor.",'".$Publico."',".$Descuento.",".$FK_RUT_cliente.");";

    $insercion_entrada = pg_query($conexion, $sql_entrada);

    $FK_Numero_entrada = $Numero_entrada;
    $FK_ID_evento_presencial = $_POST['idEventoPresencial'];
    $Numero_asiento = $_POST['numAsiento'];

    $sql_entrada_presencial = "INSERT INTO entrada_presencial VALUES (".$FK_Numero_entrada.",".$FK_ID_evento_presencial.",".$Numero_asiento.");";

    $insercion_entrada_presencial = pg_query($conexion, $sql_entrada_presencial);

    if($insercion_entrada and $insercion_entrada_presencial)
    {
        echo "Se ha agregado exitosamente la entrada presencial, su número de entrada es: <b>$Numero_entrada</b>.";
        echo "<br>";
        echo "Vuelva atrás para continuar.";
    }
    else
    {
        echo "\nSe ha producido un error al agregar la entrada presencial, intente nuevamente.";
    }
}
else
{
    echo "No se han ingresado todos los datos requeridos, vuelva atrás y complete adecuadamente.";
}
?>