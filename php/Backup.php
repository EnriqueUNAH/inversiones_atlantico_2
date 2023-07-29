<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>

    <!-- Para las alertas -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.all.min.js"></script>
    <!-- Para las alertas -->

    <link rel="stylesheet" href="assets/css/styles.css">


</head>

<body></body>

</html>


<?php
include '../php/Connet.php';
//Lineas de msj al cargar pagina de acuerdo a actualizar o eliminar datos
$day = date("d");
$mont = date("m");
$year = date("Y");
$hora = date("H-i-s");
$fecha = $day . '_' . $mont . '_' . $year;
$DataBASE = $fecha . "_(" . $hora . "_hrs).sql";
$tables = array();
$result = SGBD::sql('SHOW TABLES');

if ($result) {
    while ($row = mysqli_fetch_row($result)) {
        $tables[] = $row[0];
    }
    $sql = 'SET FOREIGN_KEY_CHECKS=0;' . "\n\n";
    $sql .= 'CREATE DATABASE IF NOT EXISTS ' . BD . ";\n\n";
    $sql .= 'USE ' . BD . ";\n\n";;
    foreach ($tables as $table) {
        $result = SGBD::sql('SELECT * FROM ' . $table);
        if ($result) {
            $numFields = mysqli_num_fields($result);
            $sql .= 'DROP TABLE IF EXISTS ' . $table . ';';
            $row2 = mysqli_fetch_row(SGBD::sql('SHOW CREATE TABLE ' . $table));
            $sql .= "\n\n" . $row2[1] . ";\n\n";
            for ($i = 0; $i < $numFields; $i++) {
                while ($row = mysqli_fetch_row($result)) {
                    $sql .= 'INSERT INTO ' . $table . ' VALUES(';
                    for ($j = 0; $j < $numFields; $j++) {
                        if (is_null($row[$j])) {
                            $sql .= 'NULL';
                        } else {
                            $row[$j] = addslashes($row[$j]);
                            $row[$j] = str_replace("\n", "\\n", $row[$j]);
                            $sql .= '"' . $row[$j] . '"';
                        }

                        if ($j < ($numFields - 1)) {
                            $sql .= ',';
                        }
                    }
                    $sql .= ");\n";
                }
            }
            $sql .= "\n\n\n";
        } else {
            $error = 1;
        }
    }

    if ($error == 1) {
        echo 'Ocurrio un error inesperado al crear la copia de seguridad';
    } else {
        chmod(BACKUP_PATH, 0777);
        $sql .= 'SET FOREIGN_KEY_CHECKS=1;';
        $handle = fopen(BACKUP_PATH . $DataBASE, 'w+');
        if (fwrite($handle, $sql)) {
            fclose($handle);

            echo '<script>
            Swal.fire({
                icon: "success",
                title: "Respaldo Exitoso",
                showConfirmButton: true,
            }).then(() => {
                window.location.href = "../php/index.php";
            });
        </script>';
        } else {
            echo 'Ocurrio un error inesperado al crear la copia de seguridad';
        }
    }
} else {
    echo 'Ocurrio un error inesperado';
}
mysqli_free_result($result);
