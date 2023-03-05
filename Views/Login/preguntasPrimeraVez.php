<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>INVERSIONES DEL ATLANTICO</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">
  <script src="Inventario_Atlantico/Js/preguntasapi.js"></script>


</head>

<body>

  <main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex justify-content-center py-4">
                <a href="preguntasPrimeraVez.php" class="logo d-flex align-items-center w-auto">
                  <img src="assets/img/logo.png" alt="">
                  <span class="d-none d-lg-block">INVERSIONES DEL ATLANTICO</span>
                </a>
              </div><!-- End Logo -->

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h4 class="card-title text-center pb-0 fs-4">CONFIGURACION DE PREGUNTAS</h4><br>
                    <p class="text-center small">SELECCIONA PREGUNTAS PARA GESTIONAR TU CUENTA</p>
                  </div>

                  <form action="preguntas.php" method="post" class="row g-3 needs-validation" novalidate="false">
                    <div class="col-12">
                      <!--<label for="yourName" class="form-label">SELECCIONE UNA PREGUNTA:</label> -->
                      <select name="pregunta" class="form-control" id="_pregunta">
                        <?php
                        include("db.php");
                        session_start();
                        // $user=$_SESSION['name'];
                        $user = $_SESSION['usuarioNuevo'];
                        echo "El usuario es: " . $user;
                        # Consulto PREGUNTAS CONTESTADAS
                        $consulta_Pregunta = "SELECT PREGUNTAS_CONTESTADAS FROM tbl_ms_usuarios where usuario = '$user'";
                        $resultado_Pregunta = mysqli_query($conexion, $consulta_Pregunta);
                        while ($valor = mysqli_fetch_array($resultado_Pregunta)) {
                          # code... 
                          $filas_Pre = $valor['PREGUNTAS_CONTESTADAS'];
                        }
                        ///////////////////////////////////////////////////////////
                        # Consulto PREGUNTAS CONTESTADAS PARA MOSTRAR EL DATO, DEBO SUMARLE UNO PARA QUE SALGA BIEN
                        $consulta_Preguntaa = "SELECT preguntas_contestadas FROM tbl_ms_usuarios where usuario = '$user'";
                        $resultado_Preguntaa = mysqli_query($conexion, $consulta_Preguntaa);
                        while ($valor = mysqli_fetch_array($resultado_Preguntaa)) {
                          # code... 
                          $Contesta = $valor['preguntas_contestadas'] + 1;
                        }
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        $consultar_parametro_contestadas = mysqli_query($conexion, "SELECT valor FROM tbl_ms_parametros WHERE id_parametro='2'");
                        while ($otra_parametro_pre = mysqli_fetch_array($consultar_parametro_contestadas)) {
                          # code...
                          $valor_p_p = $otra_parametro_pre['valor'];
                        }

                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        # Consulto ID
                        $consulta_ID = "SELECT ID_USUARIO FROM tbl_ms_usuarios where usuario = '$user'";
                        $resultado_ID = mysqli_query($conexion, $consulta_ID);
                        while ($valor2 = mysqli_fetch_array($resultado_ID)) {
                          # code...
                          $id = $valor2['ID_USUARIO'];
                        }

                        if ($filas_Pre == 0) {
                          # code...
                          $consulta = "SELECT * FROM tbl_ms_preguntas";
                          $filas_Pre = $filas_Pre + 1;
                          // $Actualizar_pregunta="UPDATE tbl_ms_usuario SET PREGUNTAS_CONTESTADAS = '$filas_Pre' WHERE USUARIO = '$user'";
                          // mysqli_query( $conexion , $Actualizar_pregunta );
                        } else {
                          # code...
                          include("db.php");
                          $consulta = "SELECT *
                              FROM db_inversiones_atlantico.tbl_ms_preguntas t2
                               WHERE NOT EXISTS (SELECT NULL
                                               FROM db_inversiones_atlantico.tbl_ms_preguntas_usuario t1
                                              WHERE t2.id_pregunta=t1.id_pregunta AND t1.id_usuario='$id')";
                        }
                        $ejecutar = mysqli_query($conexion, $consulta);
                        ?>
                        <option selected disabled value="">--Seleccionar pregunta--</option>

                        <?php foreach ($ejecutar as $opciones) : ?>
                          <option value="<?php echo $opciones['pregunta'] ?>"><?php echo $opciones['pregunta'] ?></option>
                        <?php endforeach ?>
                        <?php ?>

                      </select>
                      <div class="invalid-feedback">PREGUNTA INVALIDA!</div>
                    </div>


                    <div class="col-12">
                      <label for="yourName" class="form-label">RESPUESTA:</label>
                      <input type="text" style="text-transform:uppercase" name="respuesta" class="form-control" id="yourAnswer" required>
                      <div class="invalid-feedback">POR FAVOR, INGRESA TU RESPUESTA!</div>
                    </div>
                    <div class="col-12">
                      <button class="btn btn-primary w-100" type="submit">CONFIRMAR</button>
                    </div>

                </div>
              </div>

            </div>
          </div>
        </div>
        <?php echo "<h4>Pregunta " . $Contesta . " de " . $valor_p_p . "</h4>"; ?>

      </section>

    </div>
  </main><!-- End #main -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/chart.js/chart.min.js"></script>
  <script src="assets/vendor/echarts/echarts.min.js"></script>
  <script src="assets/vendor/quill/quill.min.js"></script>
  <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>

</html>