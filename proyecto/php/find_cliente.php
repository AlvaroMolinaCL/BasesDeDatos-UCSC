<?php
include "../conexion.php";

if (isset($_REQUEST['rutCliente']) && $_REQUEST['rutCliente'] !== '') {
    $rutCliente = $_REQUEST['rutCliente'];

    $query = "SELECT * FROM cliente WHERE rut=$rutCliente";
    $consulta = pg_query($conexion, $query);

    if (pg_num_rows($consulta) > 0) {
        if ($obj = pg_fetch_object($consulta)) {
            echo 'Datos del cliente con rut: ' . $obj->rut . '<br><br>';
            echo '<table border="1">' .
                '<th>Rut cliente</th>' .
                '<th>Nombre cliente</th>' .
                '<th>edad cliente</th>' .
                '<th>Correo electronico cliente</th>' .
                '</tr>' .
                '<tr>' .
                '<th>' . $obj->rut . '</th>' .
                '<th>' . $obj->nombre . '</th>' .
                '<th>' . $obj->edad . '</th>' .
                '<th>' . $obj->correo_electronico . '</th>' .
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
