<?php

$host = 'localhost';
$user = 'root';
$password = '';
$db = 'db_inversiones_atlantico';

$conection = @mysqli_connect($host, $user, $password, $db);

if (!$conection) {
	echo "Error en la conexión";
}
