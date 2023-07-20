<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="author" content="Diseños Alpha">
  <meta name="theme-color" content="#009688">
  <link rel="shortcut icon" href="<?= media(); ?>/images/favicon.ico">
  <!-- Main CSS-->
  <link rel="stylesheet" type="text/css" href="<?= media(); ?>/css/main.css">
  <link rel="stylesheet" type="text/css" href="<?= media(); ?>/css/style.css">

  <title><?= $data['page_tag']; ?></title>

  <style>
    .btn-outline-secondary {
      background-color: #0d6efd;
      color: white;
    }

    #txtEmailReset {
      text-transform: uppercase;
    }
  </style>
</head>

<body>
  <section class="material-half-bg">
    <div class="cover"></div>
  </section>
  <section class="login-content">
    <div class="logo">
      <h1><?= $data['page_title']; ?></h1>
    </div>

    <div class="login-box">
      <div id="divLoading">
        <div>
          <img src="<?= media(); ?>/images/loading.svg" alt="Loading">
        </div>
      </div>


      <form class="login-form" name="formLogin" id="formLogin" action="">
        <h3 class="login-head"><i class="fa fa-lg fa-fw fa-user"></i>INICIAR SESIÓN</h3>
        <div class="form-group">
          <label class="control-label">USUARIO</label>
          <input id="txtEmail" name="txtEmail" class="form-control" type="" placeholder="Usuario" autofocus onpaste="return borrarPegado(event)"  maxlength="15" onkeypress="if(this.value.length == 15) return false; ">
        </div>
        <div class="form-group">
          <label class="control-label">CONTRASEÑA</label>
          <div class="input-group">
            <input id="txtPassword" name="txtPassword" class="form-control" type="password" placeholder="Contraseña" onpaste="return borrarPegado(event)">
            <div class="input-group-append">
              <button type="button" class="btn btn-outline-secondary" id="btnTogglePassword">
                <i class="fa fa-eye-slash" id="iconTogglePassword"></i>
              </button>
            </div>
          </div>
        </div>
        <div id="alertLogin" class="text-center"></div>
        <div class="form-group btn-container">
          <button type="submit" class="btn btn-primary btn-block"><i class="fas fa-sign-in-alt"></i> INICIAR SESIÓN</button>
        </div>
        <div class="form-group"><br>
          <div class="utility">
            <p class="semibold-text mb-2"><a href="#" data-toggle="flip">¿Olvidaste tu usuario y/o contraseña?</a></p><br>
          </div>
          <p class="semibold-text mb-2"><a href="Views/Login/autoRegistro.php">Autoregistro</a></p>
        </div>
      </form>

      <!-- FORMULARIO PARA RECUPERAR CUENTA -->
      <form id="formRecetPass" name="formRecetPass" class="forget-form" action="">
        <h5 class="login-head"><i class="fa fa-lg fa-fw fa-lock"></i>¿Olvidaste contraseña?</h5>
        <div class="form-group">
          <label class="control-label">USUARIO</label>
          <input id="txtEmailReset" name="txtEmailReset" class="form-control" placeholder="Usuario">
        </div>
        <div class="form-group btn-container">
          <button type="submit" class="btn btn-primary btn-block" id="btnCorreo"><i class="fa fa-unlock fa-lg fa-fw"></i>Recuperar por correo</button>
        </div><br>
        <div class="form-group btn-container">
          <button type="submit" class="btn btn-primary btn-block" id="btnPregunta"><i class="fa fa-unlock fa-lg fa-fw"></i>Recuperar por pregunta</button>
        </div><br>
        <div class="form-group mt-3">
          <p class="semibold-text mb-0"><a href="#" data-toggle="flip"><i class="fa fa-angle-left fa-fw"></i> Atrás</a></p>
        </div>
      </form>



    </div>
  </section>
  <script>
    const base_url = "<?= base_url(); ?>";
  </script>
  <!-- Essential javascripts for application to work-->
  <script src="<?= media(); ?>/js/jquery-3.3.1.min.js"></script>
  <script src="<?= media(); ?>/js/popper.min.js"></script>
  <script src="<?= media(); ?>/js/bootstrap.min.js"></script>
  <script src="<?= media(); ?>/js/fontawesome.js"></script>
  <script src="<?= media(); ?>/js/main.js"></script>
  <!-- The javascript plugin to display page loading on top-->
  <script src="<?= media(); ?>/js/plugins/pace.min.js"></script>
  <script type="text/javascript" src="<?= media(); ?>/js/plugins/sweetalert.min.js"></script>
  <script src="<?= media(); ?>/js/<?= $data['page_functions_js']; ?>"></script>

  <script>
    //Para manipular el ojito en la parte de contraseña
    const btnTogglePassword = document.getElementById("btnTogglePassword");
    const iconTogglePassword = document.getElementById("iconTogglePassword");
    const txtPassword = document.getElementById("txtPassword");

    btnTogglePassword.addEventListener("click", function() {
      if (txtPassword.type === "password") {
        txtPassword.type = "text";
        iconTogglePassword.classList.remove("fa-eye-slash");
        iconTogglePassword.classList.add("fa-eye");
      } else {
        txtPassword.type = "password";
        iconTogglePassword.classList.remove("fa-eye");
        iconTogglePassword.classList.add("fa-eye-slash");
      }
    });

    const txtEmail = document.getElementById("txtEmail");
    txtEmail.addEventListener("input", () => {
      txtEmail.value = txtEmail.value.toUpperCase();
    });
    const formLogin = document.getElementById("formLogin");
    formLogin.addEventListener("submit", () => {
      txtEmail.value = txtEmail.value.toUpperCase();
    });

    let strEmail = document.querySelector("#txtEmailReset").value.toUpperCase();
  </script>


  <script>
    //Para que no pueda copiar ni pegar
    function borrarPegado(event) {
      event.preventDefault();
      document.execCommand("insertText", false, "");
    }
  </script>
</body>

</html>