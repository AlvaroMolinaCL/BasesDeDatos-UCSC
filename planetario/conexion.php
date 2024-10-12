<?php
//------------Variables para conexion---------
$equipo= "localhost";
$namebd= "planetario";
$puerto= "5432";
$usuario= "postgres";
$clave= "";

//------------Aqui la conexion----------------
$coneccion = pg_connect("host= $equipo
                        dbname= $namebd
                        port= $puerto
                        user= $usuario
                        password= $clave
                        ");
?>