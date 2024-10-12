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

function generarURLAleatoria($longitud = 10) {
    $caracteresPermitidos = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    $cantidadCaracteres = strlen($caracteresPermitidos);
    $urlAleatoria = '';
    for ($i = 0; $i < $longitud; $i++) {
        $indiceAleatorio = mt_rand(0, $cantidadCaracteres - 1);
        $urlAleatoria .= $caracteresPermitidos[$indiceAleatorio];
    }
    $urlCompleta = 'http://www.proyectobd.cl/' . $urlAleatoria;
    return $urlCompleta;
}


if($_POST['fechaEntrada'] != "" and $_POST['Hora'] != "" and $_POST['valorEntrada'] != ""
    and $_POST['categoriaPublico'] != "" and $_POST['Descuento'] == "" and $_POST['rutCliente'] == ""
    and $_POST['idEventoVirtual'] != "")
{
    $numero_entrada =generarNumeroAleatorio(6);
    $fecha = $_POST['fechaEntrada'];
    $hora = $_POST['Hora'];
    $valor = $_POST['valorEntrada'];
    $publico = $_POST['categoriaPublico'];

    $sql_entrada = "INSERT INTO entrada VALUES (".$numero_entrada.",'".$fecha."','".$hora."',".$valor.",'".$publico."');";

    $insercion_entrada = pg_query($conexion, $sql_entrada);

    $fk_numero_entrada = $numero_entrada;
    $url_acceso = generarURLAleatoria();
    $fk_id_evento_virtual = $_POST['idEventoVirtual'];

    $sql_entrada_virtual = "INSERT INTO entrada_virtual VALUES (".$fk_numero_entrada.",".$url_acceso.",".$fk_id_evento_virtual.");";

    $insercion_entrada_virtual = pg_query($conexion, $sql_entrada_virtual);

    if($insercion_entrada and $insercion_entrada_virtual)
    {
        echo "\nSe ha agregado exitosamente la entrada virtual, su número de entrada es: <b>$numero_entrada</b>.";
        echo "<br>";
        echo "Su URL de acceso es: <b>$url_acceso</b>";
        echo "<br>";
        echo "Vuelva atrás para continuar."; 
    }
    else
    {
        echo "Se ha producido un error al agregar la entrada virtual, intente nuevamente.";
    }
}
elseif($_POST['fechaEntrada'] != "" and $_POST['Hora'] != "" and $_POST['valorEntrada'] != ""
and $_POST['categoriaPublico'] != "" and $_POST['Descuento'] != "" and $_POST['rutCliente'] == ""
and $_POST['idEventoVirtual'] != "")
{
    $numero_entrada = generarNumeroAleatorio(6);
    $fecha = $_POST['fechaEntrada'];
    $hora = $_POST['Hora'];
    $valor = $_POST['valorEntrada'];
    $publico = $_POST['categoriaPublico'];
    $descuento = $_POST['Descuento'];

    $sql_entrada = "INSERT INTO entrada VALUES (".$numero_entrada.",'".$fecha."','".$hora."',".$valor.",'".$publico."',".$descuento.");";

    $insercion_entrada = pg_query($conexion, $sql_entrada);

    $fk_numero_entrada = $numero_entrada;
    $url_acceso =  generarURLAleatoria();
    $fk_id_evento_virtual = $_POST['idEventoVirtual'];

    $sql_entrada_virtual = "INSERT INTO entrada_virtual VALUES (".$fk_numero_entrada.",'".$url_acceso."',".$fk_id_evento_virtual.");";

    $insercion_entrada_virtual = pg_query($conexion, $sql_entrada_virtual);

    if($insercion_entrada and $insercion_entrada_virtual)
    {
        echo "\nSe ha agregado exitosamente la entrada virtual, su número de entrada es: <b>$numero_entrada</b>.";
        echo "<br>";
        echo "Su URL de acceso es: <b>$url_acceso</b>";
        echo "<br>";
        echo "Vuelva atrás para continuar.";   
    }
    else
    {
        echo "\nSe ha producido un error al agregar la entrada virtual, intente nuevamente.";
    }
}
elseif($_POST['fechaEntrada'] != "" and $_POST['Hora'] != "" and $_POST['valorEntrada'] != ""
and $_POST['categoriaPublico'] != "" and $_POST['Descuento'] == "" and $_POST['rutCliente'] != ""
and $_POST['idEventoVirtual'] != "")
{
    $numero_entrada =generarNumeroAleatorio(6);
    $fecha = $_POST['fechaEntrada'];
    $hora = $_POST['Hora'];
    $valor = $_POST['valorEntrada'];
    $publico = $_POST['categoriaPublico'];
    $fk_rut_cliente = $_POST['rutCliente'];

    $sql_entrada = "INSERT INTO entrada VALUES (".$numero_entrada.",'".$fecha."','".$hora."',".$valor.",'".$publico."',".$fk_rut_cliente.");";

    $insercion_entrada = pg_query($conexion, $sql_entrada);

    $fk_numero_entrada = $numero_entrada;
    $url_acceso =  generarURLAleatoria();
    $fk_id_evento_virtual = $_POST['idEventoVirtual'];

    $sql_entrada_virtual = "INSERT INTO entrada_virtual VALUES (".$fk_numero_entrada.",'".$url_acceso."',".$fk_id_evento_virtual.");";

    $insercion_entrada_virtual = pg_query($conexion, $sql_entrada_virtual);

    if($insercion_entrada and $insercion_entrada_virtual)
    {
        echo "\nSe ha agregado exitosamente la entrada virtual, su número de entrada es: <b>$numero_entrada</b>.";
        echo "<br>";
        echo "Su URL de acceso es: <b>$url_acceso</b>";
        echo "<br>";
        echo "Vuelva atrás para continuar.";
    }
    else
    {
        echo "\nSe ha producido un error al agregar la entrada virtual, intente nuevamente.";
    }
}
elseif($_POST['fechaEntrada'] != "" and $_POST['Hora'] != "" and $_POST['valorEntrada'] != ""
and $_POST['categoriaPublico'] != "" and $_POST['Descuento'] != "" and $_POST['rutCliente'] != ""
and $_POST['idEventoVirtual'] != "")
{
    $numero_entrada = generarNumeroAleatorio(6);
    $fecha = $_POST['fechaEntrada'];
    $hora = $_POST['Hora'];
    $valor = $_POST['valorEntrada'];
    $publico = $_POST['categoriaPublico'];
    $descuento = $_POST['Descuento'];
    $fk_rut_cliente = $_POST['rutCliente'];

    $sql_entrada = "INSERT INTO entrada VALUES (".$numero_entrada.",'".$fecha."','".$hora."',".$valor.",'".$publico."',".$descuento.",".$fk_rut_cliente.");";

    $insercion_entrada = pg_query($conexion, $sql_entrada);

    $fk_numero_entrada = $numero_entrada;
    $url_acceso =  generarURLAleatoria();
    $fk_id_evento_virtual = $_POST['idEventoVirtual'];

    $sql_entrada_virtual = "INSERT INTO entrada_virtual VALUES (".$fk_numero_entrada.",'".$url_acceso."',".$fk_id_evento_virtual.");";

    $insercion_entrada_virtual = pg_query($conexion, $sql_entrada_virtual);

    if($insercion_entrada and $insercion_entrada_virtual)
    {
        echo "\nSe ha agregado exitosamente la entrada virtual, su número de entrada es: <b>$numero_entrada</b>.";
        echo "<br>";
        echo "Su URL de acceso es: <b>$url_acceso</b>";
        echo "<br>";
        echo "Vuelva atrás para continuar.";
    }
    else
    {
        echo "\nSe ha producido un error al agregar la entrada virtual, intente nuevamente.";
    }
}
else
{
    echo "No se han ingresado todos los datos requeridos, vuelva atrás y complete adecuadamente.";
}
?>