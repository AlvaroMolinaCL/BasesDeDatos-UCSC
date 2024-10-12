<?php
include "../conexion.php";

if (isset($_REQUEST['codigoLugar']) && $_REQUEST['codigoLugar'] !== '') {
    $codigoLugar = $_REQUEST['codigoLugar'];

    $query = "SELECT * FROM lugar WHERE codigo=$codigoLugar";
    $consulta = pg_query($conexion, $query);
    
    if (pg_num_rows($consulta) > 0) {
        if ($obj = pg_fetch_object($consulta)) {
            echo 'Datos del lugar con el codigo: ' . $obj->codigo . '<br><br>';
            echo '<table border="1">' .
                '<th>Codigo de lugar</th>' .
                '<th>Nombre del lugar</th>' .
                '<th>Direccion</th>' .
                '<th>Coordenadas geograficas de latitud</th>' .
                '<th>Coordenadas geograficas de longitud</th>' .
                '<th>Ciudad</th>' .
                '</tr>' .
                '<tr>' .
                '<th>' . $obj->codigo . '</th>' .
                '<th>' . $obj->nombre_lugar . '</th>' .
                '<th>' . $obj->direccion . '</th>' .
                '<th>' . $obj->coordenadas_geograficas_latitud . '</th>' .
                '<th>' . $obj->coordenadas_geograficas_longitud . '</th>' .
                '<th>' . $obj->ciudad . '</th>' .
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
