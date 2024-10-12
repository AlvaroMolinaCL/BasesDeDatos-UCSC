<?php
include "../conexion.php";

if (isset($_REQUEST['idEventoPresencial']) && $_REQUEST['idEventoPresencial'] !== '') {
    $idEventoPresencial = $_REQUEST['idEventoPresencial'];

    $query = "SELECT id, nombre, descripcion,fecha_inicio,
    fecha_termino, hora_inicio, hora_termino, duracion,
    categoria, restriccion, fk_codigo_lugar
    FROM evento
    INNER JOIN evento_presencial
    ON evento.id=evento_presencial.fk_id WHERE id=$idEventoPresencial" ;
    $consulta = pg_query($conexion, $query);

    if (pg_num_rows($consulta) > 0) {
        if ($obj = pg_fetch_object($consulta)) {
            echo 'Datos del evento presencial con id: ' . $obj->id . '<br><br>';
            echo '<table border="1">' .
                '<th>Id del evento presencial</th>' .
                '<th>Nombre del evento</th>' .
                '<th>Descripcion</th>' .
                '<th>Fecha de inicio</th>' .
                '<th>Fecha de termino</th>' .
                '<th>Hora de inicio</th>' .
                '<th>Hora de termino</th>' .
                '<th>Duracion</th>' .
                '<th>Categoria</th>' .
                '<th>Restriccion</th>' .
                '<th>Codigo de lugar</th>' .
                '</tr>' .
                '<tr>' .
                '<th>' . $obj->id . '</th>' .
                '<th>' . $obj->nombre . '</th>' .
                '<th>' . $obj->descripcion . '</th>' .
                '<th>' . $obj->fecha_inicio . '</th>' .
                '<th>' . $obj->fecha_termino . '</th>' .
                '<th>' . $obj->hora_inicio . '</th>' .
                '<th>' . $obj->hora_termino . '</th>' .
                '<th>' . $obj->duracion . '</th>' .
                '<th>' . $obj->categoria . '</th>' .
                '<th>' . $obj->restriccion . '</th>' .
                '<th>' . $obj->fk_codigo_lugar . '</th>' .
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
