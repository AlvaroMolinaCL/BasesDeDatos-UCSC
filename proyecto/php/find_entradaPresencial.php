<?php
include "../conexion.php";

if (isset($_REQUEST['numEntrada']) && $_REQUEST['numEntrada'] !== '') {
    $numEntrada = $_REQUEST['numEntrada'];

    $query = "SELECT numero_entrada, fecha, hora,
    valor, publico, descuento, fk_rut_cliente, 
	fk_id_evento_presencial, numero_asiento
    FROM entrada
    INNER JOIN entrada_presencial
    ON entrada.numero_entrada=entrada_presencial.fk_numero_entrada
    WHERE numero_entrada=$numEntrada";
    $consulta = pg_query($conexion, $query);

    if (pg_num_rows($consulta) > 0) {
        if ($obj = pg_fetch_object($consulta)) {
            echo 'Datos de la entrada presencial con numero de entrada: ' . $obj->numero_entrada . '<br><br>';
            echo '<table border="1">' .
                '<th>Numero de entrada</th>' .
                '<th>Fecha</th>' .
                '<th>Hora</th>' .
                '<th>Valor</th>' .
                '<th>Publico</th>' .
                '<th>Descuento</th>' .
                '<th>Rut del cliente</th>' .
                '<th>ID del evento presencial</th>' .
                '<th>Numero del asiento</th>' .
                '</tr>' .
                '<tr>' .
                '<th>' . $obj->numero_entrada . '</th>' .
                '<th>' . $obj->fecha . '</th>' .
                '<th>' . $obj->hora . '</th>' .
                '<th>' . $obj->valor . '</th>' .
                '<th>' . $obj->publico . '</th>' .
                '<th>' . $obj->descuento . '</th>' .
                '<th>' . $obj->fk_rut_cliente . '</th>' .
                '<th>' . $obj->fk_id_evento_presencial . '</th>' .
                '<th>' . $obj->numero_asiento . '</th>' .
                '</tr>' .
                '</table>';
        }
    } else {
        echo 'No se encontraron resultados';
    }
} else {
    echo 'Debe completar los datos para realizar la búsqueda.';
}
?>
