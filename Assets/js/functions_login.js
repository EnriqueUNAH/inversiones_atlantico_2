$('.login-content [data-toggle="flip"]').click(function () {
  $(".login-box").toggleClass("flipped");
  return false;
});

var divLoading = document.querySelector("#divLoading");
document.addEventListener(
  "DOMContentLoaded",
  function () {
    if (document.querySelector("#formLogin")) {
      let formLogin = document.querySelector("#formLogin");
      formLogin.onsubmit = function (e) {
        e.preventDefault();

        let strEmail = document.querySelector("#txtEmail").value;
        let strPassword = document.querySelector("#txtPassword").value;

        if (strEmail == "" || strPassword == "") {
          swal("Por favor", "Escribe usuario y contraseña.", "error");
          return false;
        } else {
          divLoading.style.display = "flex";
          var request = window.XMLHttpRequest
            ? new XMLHttpRequest()
            : new ActiveXObject("Microsoft.XMLHTTP");
          var ajaxUrl = base_url + "/Login/loginUser";
          var formData = new FormData(formLogin);
          request.open("POST", ajaxUrl, true);
          request.send(formData);
          request.onreadystatechange = function () {
            if (request.readyState != 4) return;
            if (request.status == 200) {
              var objData = JSON.parse(request.responseText);
              if (objData.status) {
                //window.location = base_url+'/dashboard';
                window.location.reload(false);
              } else if (objData.statusNuevo) {
                //CUANDO EL USUARIO SEA NUEVO
                swal(
                  {
                    title: "",
                    text: objData.msg,
                    type: "info",
                    confirmButtonText: "Aceptar",
                    closeOnConfirm: false,
                  },
                  function (isConfirm) {
                    if (isConfirm) {
                      window.location =
                        base_url + "/Views/Login/preguntasPrimeraVez.php";
                    }
                  }
                );
              } else if (objData.statusBloqueado) {
                //CUANDO EL USUARIO ESTÉ BLOQUEADO
                swal(
                  {
                    title: "",
                    text: objData.msg,
                    type: "error",
                    confirmButtonText: "Aceptar",
                    closeOnConfirm: false,
                  },
                  function (isConfirm) {
                    if (isConfirm) {
                      window.location = base_url + "/login";
                    }
                  }
                );
              } else {
                swal("Atención", objData.msg, "error");
                document.querySelector("#txtPassword").value = "";
              }
            } else {
              swal("Atención", "Error en el proceso", "error");
            }
            divLoading.style.display = "none";
            return false;
          };
        }
      };
    }

    if (document.querySelector("#btnCorreo")) {
      let btnCorreo = document.querySelector("#btnCorreo");
      btnCorreo.onclick = function (e) {
        e.preventDefault();

        let formRecetPass = btnCorreo.form;
        let strEmail = document.querySelector("#txtEmailReset").value;
        if (strEmail == "") {
          swal("Por favor", "Escribe tu usuario", "error");
          return false;
        } else {
          divLoading.style.display = "flex";
          var request = window.XMLHttpRequest
            ? new XMLHttpRequest()
            : new ActiveXObject("Microsoft.XMLHTTP");

          var ajaxUrl = base_url + "/Login/resetPass";
          var formData = new FormData(formRecetPass);
          request.open("POST", ajaxUrl, true);
          request.send(formData);
          request.onreadystatechange = function () {
            if (request.readyState != 4) return;
            if (request.status == 200) {
              var objData;
              try {
                objData = JSON.parse(request.responseText.trim());
              } catch (e) {
                swal(
                  {
                    title: "",
                    text: "Se ha enviado un email a tu cuenta de correo.",
                    type: "success",
                    confirmButtonText: "Aceptar",
                    closeOnConfirm: false,
                  },
                  function (isConfirm) {
                    if (isConfirm) {
                      window.location = base_url + "/login";
                    }
                  }
                );
                return;
              }

              if (objData.status) {
                swal(
                  {
                    title: "",
                    text: objData.msg,
                    type: "success",
                    confirmButtonText: "Aceptar",
                    closeOnConfirm: false,
                  },
                  function (isConfirm) {
                    if (isConfirm) {
                      window.location = base_url;
                    }
                  }
                );
              } else {
                swal("Atención", objData.msg, "error");
              }
            } else {
              swal("Atención", "Error en el proceso", "error");
            }
            divLoading.style.display = "none";
            return false;
          };
        }
      };
    }

    if (document.querySelector("#btnPregunta")) {
      let btnPregunta = document.querySelector("#btnPregunta");
      btnPregunta.onclick = function (e) {
        e.preventDefault();

        let formRecetPass = btnPregunta.form;
        let strEmail = document.querySelector("#txtEmailReset").value;
        if (strEmail == "") {
          swal("Por favor", "Escribe tu usuario", "error");
          return false;
        } else {
          divLoading.style.display = "flex";
          var request = window.XMLHttpRequest
            ? new XMLHttpRequest()
            : new ActiveXObject("Microsoft.XMLHTTP");

          var ajaxUrl = base_url + "/Login/resetPassPregunta";
          var formData = new FormData(formRecetPass);
          request.open("POST", ajaxUrl, true);
          request.send(formData);
          request.onreadystatechange = function () {
            if (request.readyState != 4) return;
            if (request.status == 200) {
              var objData = JSON.parse(request.responseText);
              if (objData.status) {
                window.location.href = "Views/Login/validar.php";
              } else {
                swal("Atención", objData.msg, "error");
              }
            } else {
              swal("Atención", "Error en el proceso", "error");
            }
            divLoading.style.display = "none";
            return false;
          };
        }
      };
    }
    /* EJEMPLO DE ANTES
    if (document.querySelector("#btnPregunta")) {
      let btnPregunta = document.querySelector("#btnPregunta");
      let strPregunta = document.querySelector("#txtEmailReset").value;

      btnPregunta.onclick = function (e) {
        e.preventDefault();
        let formRecetPass = btnPregunta.form;
        formRecetPass.action = "Views/Login/validar.php";
        formRecetPass.submit();
      };
    }
*/

    function openModal() {
      document.querySelector("#id_rol").value = "";
      document
        .querySelector(".modal-header")
        .classList.replace("headerUpdate", "headerRegister");
      document
        .querySelector("#btnActionForm")
        .classList.replace("btn-info", "btn-primary");
      document.querySelector("#btnText").innerHTML = "Guardar";
      document.querySelector("#titleModal").innerHTML = "Nuevo Rol";
      document.querySelector("#formRol").reset();
      $("#modalFormRol").modal("show");
    }

    if (document.querySelector("#formCambiarPass")) {
      let formCambiarPass = document.querySelector("#formCambiarPass");
      formCambiarPass.onsubmit = function (e) {
        e.preventDefault();

        let strPassword = document.querySelector("#txtPassword").value;
        let strPasswordConfirm = document.querySelector(
          "#txtPasswordConfirm"
        ).value;
        let id_usuario = document.querySelector("#id_usuario").value;

        if (strPassword == "" || strPasswordConfirm == "") {
          swal("Por favor", "Escribe la nueva contraseña.", "error");
          return false;
        } else {
          if (strPassword.length < 5) {
            swal(
              "Atención",
              "La contraseña debe tener un mínimo de 5 caracteres.",
              "info"
            );
            return false;
          }
          if (strPassword != strPasswordConfirm) {
            swal("Atención", "Las contraseñas no son iguales.", "error");
            return false;
          }
          divLoading.style.display = "flex";
          var request = window.XMLHttpRequest
            ? new XMLHttpRequest()
            : new ActiveXObject("Microsoft.XMLHTTP");
          var ajaxUrl = base_url + "/Login/setPassword";
          var formData = new FormData(formCambiarPass);
          request.open("POST", ajaxUrl, true);
          request.send(formData);
          request.onreadystatechange = function () {
            if (request.readyState != 4) return;
            if (request.status == 200) {
              var objData = JSON.parse(request.responseText);
              if (objData.status) {
                swal(
                  {
                    title: "",
                    text: objData.msg,
                    type: "success",
                    confirmButtonText: "Iniciar sessión",
                    closeOnConfirm: false,
                  },
                  function (isConfirm) {
                    if (isConfirm) {
                      window.location = base_url + "/login";
                    }
                  }
                );
              } else {
                swal("Atención", objData.msg, "error");
              }
            } else {
              swal("Atención", "Error en el proceso", "error");
            }
            divLoading.style.display = "none";
          };
        }
      };
    }
  },
  false
);
