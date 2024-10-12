<?php
$equipo = "localhost";
$namebd = "proyecto_bd";
$puerto = "5432";
$usuario = "postgres";
$clave = "123456";

$conexion = pg_connect("host= $equipo
                        dbname= $namebd
                        port= $puerto
                        user= $usuario
                        password= $clave
                        ");

if(!$conexion)
{
    echo "Ha ocurrido un problema al conectarse con la base de datos.";
}
?>