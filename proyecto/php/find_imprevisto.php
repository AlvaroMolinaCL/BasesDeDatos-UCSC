<?php
include "../conexion.php";

if (isset($_REQUEST['numeroImprevisto']) && $_REQUEST['numeroImprevisto'] !== '') {
    $numeroImprevisto = $_REQUEST['numeroImprevisto'];

    $query = "SELECT * FROM imprevisto WHERE numero_imprevisto=$numeroImprevisto";
    $consulta = pg_query($conexion, $query);

    if (pg_num_rows($consulta) > 0) {
        if ($obj = pg_fetch_object($consulta)) {
            echo 'Datos del imprevisto con el numero de imprevisto: ' . $obj->numero_imprevisto . '<br><br>';
            echo '<table border="1">' .
                '<th>Numero de imprevisto</th>' .
                '<th>Descripcion</th>' .
                '<th>Categoria del imprevisto</th>' .
                '</tr>' .
                '<tr>' .
                '<th>' . $obj->numero_imprevisto . '</th>' .
                '<th>' . $obj->descripcion . '</th>' .
                '<th>' . $obj->categoria_imprevisto . '</th>' .
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
