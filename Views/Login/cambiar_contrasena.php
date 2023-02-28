<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>INVERSIONES DEL ATLANTICO</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="../assets/img/favicon.png" rel="icon">
  <link href="../assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="../assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="../assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="../assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="../assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="../assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="../assets/vendor/simple-datatables/style.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="../assets/css/style.css" rel="stylesheet">

  
  <!--librerias para contraseña-->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

  <script>
    function validatePassword() {
      var p = document.getElementById('yourPassword').value,
          errors = [];
      if (p.length < 8) {
          errors.push("TU CONTRASEÑA AL MENOS DEBE TENER 8 CARACTERES");
      }
      if (p.search(/[a-z]/i) < 0) {
          errors.push("TU CONTRASEÑA AL MENOS DEBE TENER UNA MINUSCULA"); 
      }
      if (p.search(/[A-Z]/i) < 0) {
          errors.push("TU CONTRASEÑA AL MENOS DEBE TENER UNA MAYUSCULA"); 
      }
      if (p.search(/[0-9]/) < 0) {
          errors.push("TU CONTRASEÑA AL MENOS DEBE TENER UN NUMERO");
      }
      if (p.search(/[*&!^)(#@$?¡\-_]/) < 0) {
          errors.push("TU CONTRASEÑA AL MENOS DEBE TENER UN CARACTER ESPECIAL");
      }
      if (errors.length > 0) {
          alert(errors.join("\n"));
          return false;
      }else{
        return True;
      }  
  }
  </script>
  <script>
    function mostrarPassword(){
        var cambio = document.getElementById("yourPassword");
		if(cambio.type == "password"){
			cambio.type = "text";
			$('.icon').removeClass('fa fa-eye-slash').addClass('fa fa-eye');
		}else{
			cambio.type = "password";
			$('.icon').removeClass('fa fa-eye').addClass('fa fa-eye-slash');
		}
	} 
  
	$(document).ready(function () {
	//CheckBox mostrar contraseña
    $('#ShowPassword').click(function () {
      $('#Password').attr('type', $(this).is(':checked') ? 'text' : 'password');
    });
    });
  </script>
  <script>
    function mostrarPassword_(){
        var cambio = document.getElementById("nuevo");
		if(cambio.type == "password"){
			cambio.type = "text";
			$('.icon').removeClass('fa fa-eye-slash').addClass('fa fa-eye');
		}else{
			cambio.type = "password";
			$('.icon').removeClass('fa fa-eye').addClass('fa fa-eye-slash');
		}
	} 
  
	$(document).ready(function () {
	//CheckBox mostrar contraseña
    $('#ShowPassword').click(function () {
      $('#Password').attr('type', $(this).is(':checked') ? 'text' : 'password');
    });
    });
  </script>
  <script>
    function mostrarPassword__(){
        var cambio = document.getElementById("confirmar");
		if(cambio.type == "password"){
			cambio.type = "text";
			$('.icon').removeClass('fa fa-eye-slash').addClass('fa fa-eye');
		}else{
			cambio.type = "password";
			$('.icon').removeClass('fa fa-eye').addClass('fa fa-eye-slash');
		}
	} 
  
	$(document).ready(function () {
	//CheckBox mostrar contraseña
    $('#ShowPassword').click(function () {
      $('#Password').attr('type', $(this).is(':checked') ? 'text' : 'password');
    });
    });
  </script>
 <script>
  function validar_espacio__(e, campo)
  {
  key = e.keyCode ? e.keyCode : e.which;
  if (key == 32) {return false;}
  }
  </script>

<script>
  function maximo(campo,limite)
  {
  if(campo.value.length>=limite){
  campo.value=campo.value.substring(0,limite);
  }
  }
</script>

</head>

<body>

  <main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex justify-content-center py-4">
                <a href="cambiar_contrasena.php" class="logo d-flex align-items-center w-auto">
                  <img src="../assets/img/logo.png" alt="">
                  <span class="d-none d-lg-block">INVERSIONES DEL ATLANTICO</span>
                </a>
              </div><!-- End Logo -->

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4">CAMBIAR CONTRASEÑA</h5>
                    <p class="text-center small">INGRESO DE DATOS</p>
                  </div>

                  <form action="../php/cambiarContrasena.php" method="post" class="row g-3 needs-validation" onsubmit="checkPassword(this);">
                    
                    <div class="col-12">
                      <label for="yourPassword" class="form-label">CONTRASEÑA ANTIGUA:</label>
                      <div class="input-group">
                        <input type="Password" Class="form-control" name="password" placeholder="Ingrese su antigua contraseña"  onkeypress="javascript: return validar_espacio(event,this)" class="form-control" id="yourPassword" required>
                        <div class="input-group-append">
                            <button id="show_password" class="btn btn-primary" type="button" onclick="mostrarPassword()"> <span class="fa fa-eye-slash icon"></span> </button>
                            <div class="invalid-feedback">Ingrese su antigua contraseña!</div>
                          </div>
                      </div>
                     </div> 

                     <div class="col-12">
                      <label for="yourPassword" class="form-label">NUEVA CONTRASEÑA:</label>
                      <div class="input-group">
                        <input type="Password" Class="form-control" name="password_" placeholder="Ingrese su nueva contraseña"  onkeypress="javascript: return validar_espacio(event,this)" onblur="validarPassword_(); return false;" class="form-control" id="nuevo" required>
                        <div class="input-group-append">
                            <button id="show_password" class="btn btn-primary" type="button" onclick="mostrarPassword_()"> <span class="fa fa-eye-slash icon"></span> </button>
                            <div class="invalid-feedback">Ingrese su nueva contraseña!</div>
                          </div>
                      </div>
                     </div>

                     <div class="col-12">
                      <label for="yourPassword" class="form-label">CONFIRMAR NUEVA CONTRASEÑA:</label>
                      <div class="input-group">
                        <input type="Password" Class="form-control" name="password__" placeholder="Confirme su nueva contraseña"  onkeypress="javascript: return validar_espacio(event,this)" onblur="validarPassword_(); return false;" class="form-control" id="confirmar" required>
                        <div class="input-group-append">
                            <button id="show_password" class="btn btn-primary" type="button" onclick="mostrarPassword__()"> <span class="fa fa-eye-slash icon"></span> </button>
                            <div class="invalid-feedback">Confirme su nueva contraseña!</div>
                          </div>
                      </div>
                     </div>

                    <div class="col-12">
                      <button class="btn btn-primary w-100" type="submit">ACEPTAR</button>
                    </div>



                  </form>

                </div>
              </div>

              </div>

            </div>
          </div>
        </div>

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