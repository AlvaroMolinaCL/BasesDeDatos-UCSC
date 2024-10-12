<?php
include 'conexion.php'; // Se incluye el archivo que contiene la conexion a la BD

// Funcion que imprime la busqueda individual
function printt_grupo($answer){
    if(pg_num_rows($answer)!=0){ // Condicion verifica que la respuesta de algun resultado
        echo "<hr>";
        echo "<table cellpadding='15px' >"; // Se declara una tabla en html para dar orden a la respuesta mientras se imprime
        echo "<tr>";
            echo "<th><b>ID</b></th>";
            echo "<th><b>Nombre</b></th>";
            echo "<th><b>Tipo</b></th>";
            echo "<th><b>Masas terrestres</b></th>";
            echo "<th><b>Diametro (Km)</b></th>";
            echo "<th><b>Sistema planetario</b></th>";
        echo "</tr>";
            while ($row = pg_fetch_array($answer)) // Mientras existan filas, se seguira haciendo el ciclo
            {
                echo "<tr>";
                    echo "<td ALIGN=center >".$row["id"]."</td>"; 
                    echo "<td ALIGN=center > ".$row["nombre"]."</td>";
                    echo "<td ALIGN=center > ".$row["tipo"]."</td>";
                    echo "<td ALIGN=center > ".$row["masa"]."</td>";
                    echo "<td ALIGN=center > ".$row["diametro"]."</td>";
                    echo "<td ALIGN=center > ".$row["sistema_planetario"]."</td>";
                echo "<tr>";
            }
        echo "</table>";
        echo "<hr>";
    } 
    else{ // Si la respuesta no tenia filas, se imprimira el siguiente mensaje
        echo "No se encontro resultados";
    } 

}
// Funcion que imprime busquedas con resultados de varias filas
function printt_individual($answer){
    if(pg_num_rows($answer)==1){
        $row = pg_fetch_array($answer); // Funcion obtiene una a una las filas de la respuesta almacenada en 'answer'
        echo "<hr>";
        echo "<p><b> Ficha de ".$row["nombre"].". </b></p>";
        echo "ID: ".$row["id"]." .<br>";
        echo "Tipo: ".$row["tipo"].". <br>";
        echo "Masas: ".$row["masa"]." masas tierra.  <br>";
        echo "Diametro (Km): ".$row["diametro"]." kms.<br>";
        echo "Sistema planetario: ".$row["sistema_planetario"].". <br>";
        
        echo "<hr>";
    } 
    else{
        echo "No se encontro resultados";
    } 
}

if(isset($_POST['Nombre'])){ // Verifica que 'Nombre' este ingresado perfectamente
    $busqueda = $_POST['Nombre']; // Extrae el valor de 'Nombre' que se quiere buscar
    $pregunta = "SELECT * FROM objetos WHERE nombre= '".$busqueda."'  ;"; // Consulta SQL
    $respuesta = pg_query($coneccion,$pregunta); // Ejecucion de la consulta SQL 'pregunta' en la coneccion a BD 'coneccion'.
    printt_individual($respuesta); // Se imprime la respuesta
    }
    
elseif(isset($_POST['Tipo_de_objeto'])){
    $busqueda = $_POST['Tipo_de_objeto'];
    $pregunta = "SELECT * FROM objetos WHERE tipo= '".$busqueda."'  ;";
    $respuesta = pg_query($coneccion,$pregunta);
    printt_grupo($respuesta);
    }    
else{
    echo "Se ha producido un error"; // En caso de error(isset() correspondiente devuelva false), se desplegara este mensaje:
    }
?>