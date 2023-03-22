let tableClientes;
let rowTable = "";
let divLoading = document.querySelector("#divLoading");
document.addEventListener(
  "DOMContentLoaded",
  function () {
    tableClientes = $("#tableClientes").dataTable({
      aProcessing: true,
      aServerSide: true,
      language: {
        url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json",
      },
      ajax: {
        url: " " + base_url + "/Clientes/getClientes",
        dataSrc: "",
      },
      columns: [
        { data: "rtn" },
        { data: "nombres" },
        { data: "apellidos" },
        { data: "telefono" },
        { data: "correo_electronico" },
        { data: "direccion" },
        { data: "options" },
      ],
      dom: "lBfrtip",
      buttons: [
        {
          extend: "excelHtml5",
          text: "<i class='fas fa-file-excel'></i> Excel",
          titleAttr: "Exportar a Excel",
          className: "btn btn-success",
          exportOptions: {
            columns: [0, 1, 2, 3, 4, 5],
          },
        },
        {
          extend: "pdfHtml5",
          text: "<i class='fas fa-file-pdf'></i> PDF",
          titleAttr: "Exportar a PDF",
          className: "btn btn-danger",
          exportOptions: {
            columns: [0, 1, 2, 3, 4, 5],
          },
          customize: function (doc) {
            doc.styles.tableHeader.color = "#ffffff";
            doc.styles.tableHeader.fillColor = "#007bff";
            doc.styles.tableBodyEven.fillColor = "#f2f2f2";
            doc.styles.tableBodyOdd.fillColor = "#ffffff";
            doc.content[1].table.widths = Array(
              doc.content[1].table.body[0].length + 1
            )
              .join("*")
              .split("");
          },
        },
      ],
      resonsieve: "true",
      bDestroy: true,
      iDisplayLength: 10,
      order: [[0, "desc"]],
    });

    if (document.querySelector("#formUsuario")) {
      let formUsuario = document.querySelector("#formUsuario");
      formUsuario.onsubmit = function (e) {
        e.preventDefault();

        let strusuario = document.querySelector("#txtusuario").value;
        let strnombre_usuario = document
          .querySelector("#txtnombre_usuario")
          .value.toUpperCase();
        let strEmail = document.querySelector("#txtEmail").value;
        let intpreguntas_contestadas = 0;
        let intTipousuario = document.querySelector("#listid_rol").value;
        let strPassword = document.querySelector("#txtPassword").value;
        let intStatus = document.querySelector("#listStatus").value;

        if (
          strusuario == "" ||
          strnombre_usuario == "" ||
          strEmail == "" ||
          intTipousuario == ""
        ) {
          swal("Atención", "Todos los campos son obligatorios.", "error");
          return false;
        }

        let elementsValid = document.getElementsByClassName("valid");
        for (let i = 0; i < elementsValid.length; i++) {
          if (elementsValid[i].classList.contains("is-invalid")) {
            swal(
              "Atención",
              "Por favor verifique los campos en rojo.",
              "error"
            );
            return false;
          }
        }
        divLoading.style.display = "flex";
        let request = window.XMLHttpRequest
          ? new XMLHttpRequest()
          : new ActiveXObject("Microsoft.XMLHTTP");
        let ajaxUrl = base_url + "/Usuarios/setUsuario";
        let formData = new FormData(formUsuario);
        request.open("POST", ajaxUrl, true);
        request.send(formData);
        request.onreadystatechange = function () {
          if (request.readyState == 4 && request.status == 200) {
            let objData = JSON.parse(request.responseText);
            if (objData.status) {
              if (rowTable == "") {
                tableUsuarios.api().ajax.reload();
              } else {
                htmlStatus =
                  intStatus == 1
                    ? '<span class="badge badge-success">ACTIVO</span>'
                    : intStatus == 3
                    ? '<span class="badge badge-info">NUEVO</span>'
                    : intStatus == 4
                    ? '<span class="badge badge-danger">BLOQUEADO</span>'
                    : '<span class="badge badge-danger">INACTIVO</span>';

                rowTable.cells[0].textContent = strusuario;
                rowTable.cells[1].textContent = strnombre_usuario;
                rowTable.cells[2].textContent = strEmail;
                rowTable.cells[3].textContent =
                  document.querySelector("#listid_rol").selectedOptions[0].text;
                rowTable.cells[4].innerHTML = htmlStatus;
                rowTable = "";
              }

              $("#modalFormUsuario").modal("hide");

              formUsuario.reset();
              swal("Usuarios", objData.msg, "success");
            } else {
              swal("Error", objData.msg, "error");
            }
          }
          divLoading.style.display = "none";
          return false;
        };
      };
    }

    //Actualizar Perfil
    if (document.querySelector("#formPerfil")) {
      let formPerfil = document.querySelector("#formPerfil");
      formPerfil.onsubmit = function (e) {
        e.preventDefault();
        let strusuario = document.querySelector("#txtusuario").value;
        let strnombre_usuario =
          document.querySelector("#txtnombre_usuario").value;
        let intpreguntas_contestadas = document.querySelector(
          "#txtpreguntas_contestadas"
        ).value;
        let strPassword = document.querySelector("#txtPassword").value;
        let strPasswordConfirm = document.querySelector(
          "#txtPasswordConfirm"
        ).value;

        if (
          strusuario == "" ||
          strnombre_usuario == "" ||
          intpreguntas_contestadas == ""
        ) {
          swal("Atención", "Todos los campos son obligatorios.", "error");
          return false;
        }

        if (strPassword != "" || strPasswordConfirm != "") {
          if (strPassword != strPasswordConfirm) {
            swal("Atención", "Las contraseñas no son iguales.", "info");
            return false;
          }
          if (strPassword.length < 5) {
            swal(
              "Atención",
              "La contraseña debe tener un mínimo de 5 caracteres.",
              "info"
            );
            return false;
          }
        }

        let elementsValid = document.getElementsByClassName("valid");
        for (let i = 0; i < elementsValid.length; i++) {
          if (elementsValid[i].classList.contains("is-invalid")) {
            swal(
              "Atención",
              "Por favor verifique los campos en rojo.",
              "error"
            );
            return false;
          }
        }
        divLoading.style.display = "flex";
        let request = window.XMLHttpRequest
          ? new XMLHttpRequest()
          : new ActiveXObject("Microsoft.XMLHTTP");
        let ajaxUrl = base_url + "/Usuarios/putPerfil";
        let formData = new FormData(formPerfil);
        request.open("POST", ajaxUrl, true);
        request.send(formData);
        request.onreadystatechange = function () {
          if (request.readyState != 4) return;
          if (request.status == 200) {
            let objData = JSON.parse(request.responseText);
            if (objData.status) {
              $("#modalFormPerfil").modal("hide");
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
                    location.reload();
                  }
                }
              );
            } else {
              swal("Error", objData.msg, "error");
            }
          }
          divLoading.style.display = "none";
          return false;
        };
      };
    }
    //Actualizar Datos Fiscales
    if (document.querySelector("#formDataFiscal")) {
      let formDataFiscal = document.querySelector("#formDataFiscal");
      formDataFiscal.onsubmit = function (e) {
        e.preventDefault();
        let strNit = document.querySelector("#txtNit").value;
        let strNombreFiscal = document.querySelector("#txtNombreFiscal").value;
        let strDirFiscal = document.querySelector("#txtDirFiscal").value;

        if (strNit == "" || strNombreFiscal == "" || strDirFiscal == "") {
          swal("Atención", "Todos los campos son obligatorios.", "error");
          return false;
        }
        divLoading.style.display = "flex";
        let request = window.XMLHttpRequest
          ? new XMLHttpRequest()
          : new ActiveXObject("Microsoft.XMLHTTP");
        let ajaxUrl = base_url + "/Usuarios/putDFical";
        let formData = new FormData(formDataFiscal);
        request.open("POST", ajaxUrl, true);
        request.send(formData);
        request.onreadystatechange = function () {
          if (request.readyState != 4) return;
          if (request.status == 200) {
            let objData = JSON.parse(request.responseText);
            if (objData.status) {
              $("#modalFormPerfil").modal("hide");
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
                    location.reload();
                  }
                }
              );
            } else {
              swal("Error", objData.msg, "error");
            }
          }
          divLoading.style.display = "none";
          return false;
        };
      };
    }
  },
  false
);

window.addEventListener(
  "load",
  function () {
    fntRolesUsuario();
  },
  false
);

function fntRolesUsuario() {
  if (document.querySelector("#listid_rol")) {
    let ajaxUrl = base_url + "/Roles/getSelectRoles";
    let request = window.XMLHttpRequest
      ? new XMLHttpRequest()
      : new ActiveXObject("Microsoft.XMLHTTP");
    request.open("GET", ajaxUrl, true);
    request.send();
    request.onreadystatechange = function () {
      if (request.readyState == 4 && request.status == 200) {
        document.querySelector("#listid_rol").innerHTML = request.responseText;
        $("#listid_rol").selectpicker("render");
      }
    };
  }
}

function fntViewUsuario(id_usuario) {
  let request = window.XMLHttpRequest
    ? new XMLHttpRequest()
    : new ActiveXObject("Microsoft.XMLHTTP");
  let ajaxUrl = base_url + "/Usuarios/getUsuario/" + id_usuario;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      let objData = JSON.parse(request.responseText);

      if (objData.status) {
        let estadoUsuario =
          objData.data.estado == 1
            ? '<span class="badge badge-success">ACTIVO</span>'
            : objData.data.estado == 3
            ? '<span class="badge badge-info">NUEVO</span>'
            : '<span class="badge badge-danger">INACTIVO</span>';

        document.querySelector("#celusuario").innerHTML = objData.data.usuario;
        document.querySelector("#celNombre").innerHTML =
          objData.data.nombre_usuario;
        document.querySelector("#celpreguntas_contestadas").innerHTML =
          objData.data.preguntas_contestadas;
        document.querySelector("#celEmail").innerHTML =
          objData.data.correo_electronico;
        document.querySelector("#celTipoUsuario").innerHTML =
          objData.data.nombrerol;
        document.querySelector("#celEstado").innerHTML = estadoUsuario;
        document.querySelector("#celFechaUltimaConexion").innerHTML =
          objData.data.fecha_ultima_conexion;
        document.querySelector("#celFechaVencimiento").innerHTML =
          objData.data.fecha_vencimiento;
        document.querySelector("#celPrimerIngreso").innerHTML =
          objData.data.primer_ingreso;
        document.querySelector("#celCreadoPor").innerHTML =
          objData.data.creado_por;
        document.querySelector("#celFechaRegistro").innerHTML =
          objData.data.fechaRegistro;
        document.querySelector("#celModificadoPor").innerHTML =
          objData.data.modificado_por;
        document.querySelector("#celFechaModificacion").innerHTML =
          objData.data.fecha_modificacion;

        $("#modalViewUser").modal("show");
      } else {
        swal("Error", objData.msg, "error");
      }
    }
  };
}

//Función cuando se le da click al botón editar Usuario
function fntEditUsuario(element, id_usuario) {
  rowTable = element.parentNode.parentNode.parentNode;
  document.querySelector("#titleModal").innerHTML = "Actualizar Usuario";
  document
    .querySelector(".modal-header")
    .classList.replace("headerRegister", "headerUpdate");
  document
    .querySelector("#btnActionForm")
    .classList.replace("btn-primary", "btn-info");
  document.querySelector("#btnText").innerHTML = "Actualizar";
  let request = window.XMLHttpRequest
    ? new XMLHttpRequest()
    : new ActiveXObject("Microsoft.XMLHTTP");
  let ajaxUrl = base_url + "/Usuarios/getUsuario/" + id_usuario;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      let objData = JSON.parse(request.responseText);

      if (objData.status) {
        document.querySelector("#id_usuario").value = objData.data.id_usuario;

        document.querySelector("#txtusuario").value = objData.data.usuario;

        //Si recibe un usuario, quiere decir que está editando,
        //entonces coloca el input de Usuario como solo lectura
        if (id_usuario) {
          document.querySelector("#txtusuario").setAttribute("readonly", true);
        }

        document.querySelector("#txtnombre_usuario").value =
          objData.data.nombre_usuario;
        document.querySelector("#txtEmail").value =
          objData.data.correo_electronico;
        document.querySelector("#listid_rol").value = objData.data.id_rol;
        $("#listid_rol").selectpicker("render");

        if (objData.data.estado == 1) {
          document.querySelector("#listStatus").value = 1;
        } else if (objData.data.estado == 2) {
          document.querySelector("#listStatus").value = 2;
        } else {
          document.querySelector("#listStatus").value = 3;
        }

        $("#listStatus").selectpicker("render");
      }
    }

    $("#modalFormUsuario").modal("show");
  };
}

function fntDelUsuario(id_usuario) {
  swal(
    {
      title: "Eliminar Usuario",
      text: "¿Realmente quiere eliminar el Usuario?",
      type: "warning",
      showCancelButton: true,
      confirmButtonText: "ELIMINAR",
      cancelButtonText: "CANCELAR",
      closeOnConfirm: false,
      closeOnCancel: true,
    },
    function (isConfirm) {
      if (isConfirm) {
        let request = window.XMLHttpRequest
          ? new XMLHttpRequest()
          : new ActiveXObject("Microsoft.XMLHTTP");
        let ajaxUrl = base_url + "/Usuarios/delUsuario";
        let strData = "id_usuario=" + id_usuario;
        request.open("POST", ajaxUrl, true);
        request.setRequestHeader(
          "Content-type",
          "application/x-www-form-urlencoded"
        );
        request.send(strData);
        request.onreadystatechange = function () {
          if (request.readyState == 4 && request.status == 200) {
            let objData = JSON.parse(request.responseText);
            if (objData.status) {
              swal("Eliminar!", objData.msg, "success");
              tableUsuarios.api().ajax.reload();
            } else if (objData.statusReferencial) {
              swal("Atención!", objData.msg, "error");
              tableUsuarios.api().ajax.reload();
            } else {
              swal("Atención!", objData.msg, "error");
            }
          }
        };
      }
    }
  );
}

//Abre el modal para agregar usuario
function openModal() {
  rowTable = "";
  document.querySelector("#cod_cliente").value = "";
  //document.querySelector("#txtusuario").removeAttribute("readonly"); //Para quitar el readonly en caso de que antes se haya editado
  //document.querySelector("#listStatus").setAttribute("readonly", true);
  // document.querySelector("#listStatus").setAttribute("disabled", true);
  // if (rowTable) {
  //   document.querySelector("#listStatus").removeAttribute("disabled");
  // } else {
  //   // Si se está agregando un nuevo registro
  //   document.querySelector("#listStatus").value = "3";
  //   document.querySelector("#listStatus").setAttribute("disabled", true);
  // }
  document
    .querySelector(".modal-header")
    .classList.replace("headerUpdate", "headerRegister");
  document
    .querySelector("#btnActionForm")
    .classList.replace("btn-info", "btn-primary");
  document.querySelector("#btnText").innerHTML = "Guardar";
  document.querySelector("#titleModal").innerHTML = "Nuevo Clientes";
  document.querySelector("#formCliente").reset();
  //$("#listStatus").prop("disabled", true);
  //$("#listStatus").val("3");

  $("#modalFormCliente").modal("show");
}

function openModalPerfil() {
  $("#modalFormPerfil").modal("show");
}
