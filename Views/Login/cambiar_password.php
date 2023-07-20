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

  <style>
    .btn-outline-secondary {
      background-color: #0d6efd;
      color: white;
    }
  </style>

  <title><?= $data['page_tag']; ?></title>
</head>

<body>
  <section class="material-half-bg">
    <div class="cover"></div>
  </section>
  <section class="login-content">
    <div class="logo">
      <h1><?= $data['page_title']; ?></h1>
    </div>
    <div class="login-box flipped">
      <div id="divLoading">
        <div>
          <img src="<?= media(); ?>/images/loading.svg" alt="Loading">
        </div>
      </div>
      <form id="formCambiarPass" name="formCambiarPass" class="forget-form" action="">
        <input type="hidden" id="id_usuario" name="id_usuario" value="<?= $data['id_usuario']; ?>" required>
        <input type="hidden" id="txtEmail" name="txtEmail" value="<?= $data['correo_electronico']; ?>" required>
        <input type="hidden" id="txtToken" name="txtToken" value="<?= $data['token']; ?>" required>
        <h3 class="login-head"><i class="fas fa-key"></i> Cambiar contraseña</h3>
        <div class="form-group col-md-16 d-flex align-items-center">
          <input id="txtPassword" name="txtPassword" class="form-control" type="password" placeholder="Nueva contraseña" required onpaste="return borrarPegado(event)">
          <button type="button" class="btn btn-outline-secondary" id="btnTogglePassword">
            <i class="fa fa-eye-slash" id="iconTogglePassword"></i>
          </button>
        </div>
        <label>Min/Max de 5 a 16 caracteres</label>
        <div class="form-group col-md-16 d-flex align-items-center">
          <input id="txtPasswordConfirm" name="txtPasswordConfirm" class="form-control" type="password" placeholder="Confirmar contraseña" required onpaste="return borrarPegado(event)">
          <button type="button" class="btn btn-outline-secondary" id="btnTogglePassword2">
            <i class="fa fa-eye-slash" id="iconTogglePassword2"></i>
          </button>
        </div>
        <div class="form-group btn-container">
          <button type="submit" class="btn btn-primary btn-block"><i class="fa fa-unlock fa-lg fa-fw"></i>REINICIAR</button>
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
</body>

</html>


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

  const btnTogglePassword2 = document.getElementById("btnTogglePassword2");
  const iconTogglePassword2 = document.getElementById("iconTogglePassword2");
  const txtPasswordConfirm = document.getElementById("txtPasswordConfirm");

  btnTogglePassword2.addEventListener("click", function() {
    if (txtPasswordConfirm.type === "password") {
      txtPasswordConfirm.type = "text";
      iconTogglePassword2.classList.remove("fa-eye-slash");
      iconTogglePassword2.classList.add("fa-eye");
    } else {
      txtPasswordConfirm.type = "password";
      iconTogglePassword2.classList.remove("fa-eye");
      iconTogglePassword2.classList.add("fa-eye-slash");
    }
  });


  //Para que no pueda copiar ni pegar
  function borrarPegado(event) {
    event.preventDefault();
    document.execCommand("insertText", false, "");
  }
</script>