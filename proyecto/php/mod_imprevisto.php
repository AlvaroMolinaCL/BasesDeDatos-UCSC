<?php
include "../conexion.php";

if($_POST['numImprevisto'] != "" && $_POST['descripcionImprevisto'] != ""
        && $_POST['categoriaImprevisto'] == "0") 
{
    $Num_imprevisto = $_POST['numImprevisto'];
    $Descripcion_imprevisto = $_POST['descripcionImprevisto'];

    $sql_imprevisto = "UPDATE imprevisto SET descripcion = '".$Descripcion_imprevisto."' WHERE numero_imprevisto = '".$Num_imprevisto."'";

    $actualizacion_imprevisto = pg_query($conexion, $sql_imprevisto);

    if($actualizacion_imprevisto) {
        echo "Se ha actualizado exitosamente la informacion de imprevisto, vuelva atrás para continuar.";
    } else {
        echo "Se ha producido un error al actualizar la informacion de imprevisto, intente nuevamente.";
    }
}
elseif($_POST['numImprevisto'] != "" && $_POST['descripcionImprevisto'] == ""
        && $_POST['categoriaImprevisto'] != "0")
{
        $Num_imprevisto = $_POST['numImprevisto'];
        $Categoria_imprevisto = $_POST['categoriaImprevisto'];
        
        $sql_imprevisto = "UPDATE imprevisto SET categoria_imprevisto = '".$Categoria_imprevisto."' WHERE numero_imprevisto = '".$Num_imprevisto."'";
        
        $actualizacion_imprevisto = pg_query($conexion, $sql_imprevisto);
        
        if($actualizacion_imprevisto) {
            echo "Se ha actualizado exitosamente la informacion de imprevisto, vuelva atrás para continuar.";
        }
        else{
                echo "Se ha producido un error al actualizar la informacion de imprevisto, intente nuevamente.";
        }
}
else {
    echo "No se han ingresado todos los datos requeridos, vuelva atrás y complete adecuadamente.";
}

?>