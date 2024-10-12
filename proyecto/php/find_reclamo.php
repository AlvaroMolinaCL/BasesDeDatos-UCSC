<?php
include "../conexion.php";

if (isset($_REQUEST['codigoReclamo']) && $_REQUEST['codigoReclamo'] !== '') {
    $codigoReclamo = $_REQUEST['codigoReclamo'];

    $query = "SELECT * FROM reclamo WHERE codigo_reclamo=$codigoReclamo";
    $consulta = pg_query($conexion, $query);

    if (pg_num_rows($consulta) > 0) {
        if ($obj = pg_fetch_object($consulta)) {
            echo 'Datos del reclamo con codigo: ' . $obj->codigo_reclamo . '<br><br>';
            echo '<table border="1">' .
                '<th>Codigo reclamo</th>' .
                '<th>Descripcion</th>' .
                '<th>Categoria reclamo</th>' .
                '<th>Rut del cliente</th>' .
                '</tr>' .
                '<tr>' .
                '<th>' . $obj->codigo_reclamo . '</th>' .
                '<th>' . $obj->descripcion . '</th>' .
                '<th>' . $obj->categoria_reclamo . '</th>' .
                '<th>' . $obj->fk_rut_cliente . '</th>' .
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
