<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>IVERSIONES DEL ATLANTICO</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="Assets/img/favicon.png" rel="icon">
  <link href="Assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="Assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="Assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="Assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="Assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="Assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="Assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="Assets/vendor/simple-datatables/style.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="Assets/css/style.css" rel="stylesheet">

  
  <!--librerias para contraseña-->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

  
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
    function mostrarPassword1(){
        var cambio = document.getElementById("yourPassword1");
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
    function validar_espacio(e, campo)
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

<script>
  function validatePassword() {
    var p = document.getElementById('yourPassword').value,
        errors = [];
    if (p.length < 8) {
        errors.push("TU CONTRASEÑA AL MENOS DEBE TENER 8 CARACTERES");
    }
    if (p.search(/[a-z]/) < 0) {
        errors.push("TU CONTRASEÑA AL MENOS DEBE TENER UNA MINUSCULA"); 
    }
    if (p.search(/[A-Z]/) < 0) {
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

</head>

<body>

  <main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex justify-content-center py-4">
                <a href="index.html" class="logo d-flex align-items-center w-auto">
                  <img src="Assets/img/logo.png" alt="">
                  <span class="d-none d-lg-block">INVERSIONES DEL ATLANTICO</span>
                </a>
              </div><!-- End Logo -->

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4">CAMBIAR CONTRASEÑA</h5>
                    <p class="text-center small">INGRESO DE DATOS</p>
                  </div>

                  <form action="validarcontra_recu.php" method="post"  onsubmit="validatePassword(); return false;" method="post" class="row g-3 needs-validation" onsubmit="checkPassword(this);">
                    

                  <div class="col-12">
                      <label for="yourPassword" class="form-label">CONTRASEÑA:</label>
                      <div class="input-group">
                        <input type="Password" Class="form-control" name="password" placeholder="Ingrese su contraseña"  onkeypress="javascript: return validar_espacio(event,this)" class="form-control" id="yourPassword" required>
                        <div class="input-group-append">
                            <button id="show_password" class="btn btn-primary" type="button" onclick="mostrarPassword()"> <span class="fa fa-eye-slash icon"></span> </button>
                        </div>
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="yourPassword" class="form-label">CONFIRMAR CONTRASEÑA:</label>
                      <div class="input-group">
                        <input type="Password" Class="form-control" name="password1" placeholder="Confirme su contraseña"  onkeypress="javascript: return validar_espacio(event,this)" class="form-control" id="yourPassword1" required>
                        <div class="input-group-append">
                            <button id="show_password" class="btn btn-primary" type="button" onclick="mostrarPassword1()"> <span class="fa fa-eye-slash icon"></span> </button>
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
  <script src="Assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="Assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="Assets/vendor/chart.js/chart.min.js"></script>
  <script src="Assets/vendor/echarts/echarts.min.js"></script>
  <script src="Assets/vendor/quill/quill.min.js"></script>
  <script src="Assets/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="Assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="Assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="Assets/js/main.js"></script>

</body>

</html>