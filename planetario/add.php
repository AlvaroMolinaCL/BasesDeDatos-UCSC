<?php
include 'conexion.php';

if($_POST['Id']!="" and $_POST['Nombre']!=""){ 
    $id= $_POST['Id'];
    $nombre= $_POST['Nombre'];
    $masa= $_POST['Masa'];
    $diametro= $_POST['Diametro'];
    $tipo= $_POST['Tipo_de_objeto'];
    $sistema = $_POST['Sistema_planetario'];

    
    $sql="INSERT INTO objetos VALUES (".$id.",'".$nombre."','".$tipo."',".$masa.",".$diametro.",'".$sistema."');";
    $insercion = pg_query($coneccion,$sql);
    
    if($insercion){
        echo "Guardado con exito, vuelva atras para continuar.";
        }
    else{
        echo "Se ha producido un error al guardar";
        }
    }
else{
    echo "Datos incompletos, vuelva atras y complete adecuadamente";
    }
?>

