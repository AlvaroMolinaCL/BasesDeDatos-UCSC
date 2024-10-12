<?php
include "../conexion.php";

if (isset($_REQUEST['rutProductora']) && $_REQUEST['rutProductora'] !== '') {
    $rutProductora = $_REQUEST['rutProductora'];

    $query = "SELECT * FROM productora WHERE rut=$rutProductora";
    $consulta = pg_query($conexion, $query);

    if (pg_num_rows($consulta) > 0) {
        if ($obj = pg_fetch_object($consulta)) {
            echo 'Datos de la productora con rut: ' . $obj->rut . '<br><br>';
            echo '<table border="1">' .
                '<th>Rut productora</th>' .
                '<th>Nombre productora</th>' .
                '</tr>' .
                '<tr>' .
                '<th>' . $obj->rut . '</th>' .
                '<th>' . $obj->nombre . '</th>' .
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
