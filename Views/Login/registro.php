<?php
session_start();
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception; 
include( 'db.php' );
$nombre = strtoupper($_POST[ 'name' ]);
$usuario = strtoupper($_POST[ 'username' ]);
$_SESSION['name']=$usuario;
$contrasena = ($_POST[ 'password' ]);
$hash=password_hash($_POST[ 'password' ], PASSWORD_DEFAULT);
$correo = ($_POST[ 'email' ]);
$fechaC = date('Y-m-d');
$fecha_v = date('Y-m-d');


$consulta="SELECT Max(id_usuario) FROM tbl_ms_usuarios";
$result = mysqli_query($conexion,$consulta);
$row = mysqli_fetch_array($result);
$max = $row[0];
$filas=$max + 1;

//id bitacora
$consulta_bita="SELECT * FROM tbl_ms_bitacora";
$resultado_bita= mysqli_query( $conexion , $consulta_bita );
$filas_bi = mysqli_num_rows( $resultado_bita );
$filas_bbitacora=$filas_bi+1;

#Consulta para saber si el usuario ya existe
$consulta_="SELECT Usuario FROM tbl_ms_usuarios WHERE Usuario='$usuario'";
$resultado_= mysqli_query( $conexion , $consulta_ );
$filas_ = mysqli_num_rows( $resultado_ );

#Consulta para saber el parametro de fecha vencimiento
$consulta_Parametro_fecha="SELECT VALOR FROM tbl_ms_parametros where id_parametro = '4'";
$resultado_Parametro_fecha=mysqli_query( $conexion , $consulta_Parametro_fecha );
while ($valor_fecha=mysqli_fetch_array( $resultado_Parametro_fecha )) {
    $parametro_fecha=$valor_fecha['VALOR'];
}

//consulta si el coreo ya existe
$consultaCoreeo="SELECT correo_electronico FROM tbl_ms_usuarios WHERE correo_electronico='$correo'";
$resultado_Correo= mysqli_query( $conexion , $consultaCoreeo );
$_filas_ = mysqli_num_rows( $resultado_Correo );

//sumo 30 días
$fecha_v = date("Y-m-d",strtotime($fecha_v."+ $parametro_fecha days")); 


//$insertar_fecha_v = "SELECT DATE_ADD('2018-01-01', INTERVAL $parametro_fecha DAY);"



    #select ID_USUARIO
   // $consulta_id="SELECT ID_USUARIO FROM tbl_ms_usuarios WHERE Usuario='$usuario'";
    //$resultado_id= mysqli_query( $conexion , $consulta_id );
    //$filas_id = mysqli_num_rows( $resultado_id );

    #Confirmar contraseña
    $conformarContra = $_POST[ 'password1' ];


    if($filas_ ){
        echo '<script>alert("Nombre de usuario ya existente");</script>';
         include('../Login/autoRegistro.php');
    }elseif($contrasena!=$conformarContra){
        echo '<script>alert("Contraseñas no coinciden");</script>';
        include('../Login/autoRegistro.php');
    }elseif($_filas_){?>
        <script> 
           alert("Correo Electronico ya existente");
           location.href= "../Login/autoRegistro.php";
        </SCRipt>
        <?php
    }else{
        $contrasenaA = $contrasena;
        $insertar="INSERT INTO tbl_ms_usuarios VALUES('$filas','$usuario','$nombre','3','$hash','$fechaC','0','0','$fecha_v','$correo','$usuario','$fechaC','$usuario','$fechaC','2')";
        mysqli_query( $conexion , $insertar );

        $insertar1="INSERT INTO usuario VALUES('$filas','0','$usuario','$correo','$usuario','$hash','2','1')";
        mysqli_query( $conexion , $insertar1 );

        $bitacora="INSERT INTO tbl_ms_bitacora VALUES('$filas_bbitacora','$fechaC','$filas','3','AUTOREGISTRO','AUTOREGISTRO DE USUARIO DESDE EL LOGIN')";
        mysqli_query( $conexion , $bitacora );
        echo '<script>alert("Usuario Creado satisfactoriamente");</script>';

    //code...

    // Load Composer's autolveder
    require '../PHPMailer/src/Exception.php';
    require '../PHPMailer/src/PHPMailer.php';
    require '../PHPMailer/src/SMTP.php';

$body="";
$body .='<!DOCTYPE html>';
$body .='<html lang="es" xmlns="http://www.w3.org/1999/xhtml" xmlns:o="urn:schemas-microsoft-com:office:office">';
$body.='<head>';
$body.='<meta charset="UTF-8">';
$body.=' <meta name="viewport" content="width=device-width,initial-scale=1">';
$body.='<meta name="x-apple-disable-message-reformatting">';
$body.='<title></title>';
$body.='</head>';
$body.='<body style="margin:0;padding:0;">';
$body.='<table role="presentation" style="width:100%;border-collapse:collapse;border:0;border-spacing:0;background:#ffffff;">';
$body.='<tr>';
$body.='<td align="center" style="padding:0;">';
$body.='<table role="presentation" style="width:340px;border-collapse:collapse;border:1px solid #cccccc;border-spacing:0;text-align:left;">';
$body.='<tr>';
$body.='<tr>';
$body.='<td style="padding:36px 30px 42px 30px;">';
$body.='<table role="presentation" style="width:100%;border-collapse:collapse;border:0;border-spacing:0;">';
$body.='<tr>';
$body.='<td style="padding:0 0 36px 0;color:#153643;">';
$body.='<h1 style="font-size:24px;margin:0 0 20px 0;font-family:Arial,sans-serif;">INVERSIONES DEL ATLANTICO</h1>';
$body.='<p style="margin:0 0 12px 0;font-size:16px;line-height:24px;font-family:Arial,sans-serif;"></p>';
$body.='<p style="margin:0;font-size:16px;line-height:24px;font-family:Arial,sans-serif;"><a href="http://localhost/Inversiones_Atlantico/php/index.php" style="color:#ee4c50;text-decoration:underline;">INVERISONES DEL ATLANTICO</a></p>';
$body.='</td>';
$body.='</tr>';
$body.='<tr>';
$body.='<td style="padding:0;">';
$body.='<table role="presentation" style="width:100%;border-collapse:collapse;border:0;border-spacing:0;">';
$body.='<tr>';
$body.='<td style="width:200px;padding:0;vertical-align:top;color:#153643;">';
$body.='<p style="margin:0 0 25px 0;font-size:16px;line-height:24px;font-family:Arial,sans-serif;"><img src="https://assets.codepen.io/210284/left.gif" alt="" width="260" style="height:auto;display:block;" /></p>';
$body.='<p style="margin:0 0 12px 0;font-size:16px;line-height:24px;font-family:Arial,sans-serif;">NUEVO USUARIO CREADO</p>'.'<p></p>'.$usuario;
$body.='<p style="margin:0;font-size:16px;line-height:24px;font-family:Arial,sans-serif;"><a href="http://localhost/Inversiones_Atlantico/php/index.php" style="color:#ee4c50;text-decoration:underline;">Entrar</a></p>';
$body.='</td>';
//$body.='<td style="width:20px;padding:0;font-size:0;line-height:0;">&nbsp;</td>';
//$body.='<td style="width:260px;padding:0;vertical-align:top;color:#153643;">';
//$body.='<p style="margin:0 0 25px 0;font-size:16px;line-height:24px;font-family:Arial,sans-serif;"><img src="https://assets.codepen.io/210284/right.gif" alt="" width="260" style="height:auto;display:block;" /></p>';
//$body.='<p style="margin:0 0 12px 0;font-size:16px;line-height:24px;font-family:Arial,sans-serif;">Contraseña con un tiempo de validez determinado por Inversiones del Atlantico.</p>';
//$body.='<p style="margin:0;font-size:16px;line-height:24px;font-family:Arial,sans-serif;"><a href="http://localhost/Inversiones_Atlantico/php/index.php" style="color:#ee4c50;text-decoration:underline;">Entrar</a></p>';
//$body.='</td>';
$body.='</tr>';
$body.='</table>';
$body.='</td>';
$body.='</tr>';
$body.='</table>';
$body.='</td>';
$body.='</tr>';
$body.='<tr>';
$body.='<td style="padding:30px;background:#1f9dc4;">';
$body.='<table role="presentation" style="width:100%;border-collapse:collapse;border:0;border-spacing:0;font-size:9px;font-family:Arial,sans-serif;">';
$body.='<tr>';
$body.='<td style="padding:0;width:50%;" align="left">';
$body.='<p style="margin:0;font-size:14px;line-height:16px;font-family:Arial,sans-serif;color:#ffffff;">';
$body.='&reg; Diseños Alpha, Inventarios del Atlantico 2022<br/><a href="http://www.example.com" style="color:#ffffff;text-decoration:underline;">Unsubscribe</a>';
$body.='</p>';
$body.='</td>';
$body.='<td style="padding:0;width:50%;" align="right">';
$body.='<table role="presentation" style="border-collapse:collapse;border:0;border-spacing:0;">';
$body.='<tr>';
$body.='<td style="padding:0 0 0 10px;width:38px;">';
$body.='<a href="http://www.twitter.com/" style="color:#ffffff;"><img src="https://assets.codepen.io/210284/tw_1.png" alt="Twitter" width="38" style="height:auto;display:block;border:0;" /></a>';
$body.='</td>';
$body.='<td style="padding:0 0 0 10px;width:38px;">';
$body.='<a href="http://www.facebook.com/" style="color:#ffffff;"><img src="https://assets.codepen.io/210284/fb_1.png" alt="Facebook" width="38" style="height:auto;display:block;border:0;" /></a>';
$body.='</td>';
$body.='</tr>';
$body.='</table>';
$body.='</td>';
$body.='</tr>';
$body.='</table>';
$body.='</td>';
$body.='</tr>';
$body.='</table>';
$body.='</td>';
$body.='</tr>';
$body.='</table>';
$body.='</body>';
$body.='</html>';

    //Create a new PHPMailer instance
    $mail = new PHPMailer(true);
        //Server settings
        //$mail->SMTPDebug = SMTP::DEBUG_SERVER;                      //Enable verbose debug output
        $mail->isSMTP();                                            //Send using SMTP
        $mail->Host       = 'smtp.office365.com';                     //Set the SMTP server to send through
        $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
        $mail->Username   = 'inververionesdelatlantico@hotmail.com';                     //SMTP username
        $mail->Password   = 'ffzmvlqtrfmalady';                               //SMTP password
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;            //Enable implicit TLS encryption
        $mail->Port       = 587;                                    //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`
    
        //Recipients
        $mail->setFrom('inververionesdelatlantico@hotmail.com', 'Mailer Inversiones del Atlantico');
        $mail->addAddress($correo);     //Add a recipient
    
        //Content
        $mail->isHTML(TRUE);                                  //Set email format to HTML
        $mail->Subject = 'USUARIO CREADO';
        $mail->Body    =  $body;


        
        $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';
    
        $mail->send();

    echo '<script>alert("CORREO ENVIADO CON EXITO");</script>';


        include('../Login/preguntasPrimeraVez.php');
    }
    mysqli_close($conexion);

?>
        