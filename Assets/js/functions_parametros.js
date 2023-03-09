let tableParametros;
let rowTable = "";
let divLoading = document.querySelector("#divLoading");
document.addEventListener(
  "DOMContentLoaded",
  function () {
    tableParametros = $("#tableParametros").dataTable({
      aProcessing: true,
      aServerSide: true,
      language: {
        url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json",
      },
      ajax: {
        url: " " + base_url + "/Parametros/getParametros",
        dataSrc: "",
      },
      columns: [
        { data: "parametro" },
        { data: "valor" },
        // { data: "creado_por" },
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
            columns: [0, 1],
          },
        },
        {
          extend: "pdfHtml5",
          text: "<i class='fas fa-file-pdf'></i> PDF",
          titleAttr: "Exportar a PDF",
          className: "btn btn-danger",
          exportOptions: {
            columns: [0, 1],
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

    if (document.querySelector("#formParametros")) {
      let formParametros = document.querySelector("#formParametros");
      formParametros.onsubmit = function (e) {
        e.preventDefault();

        let strparametro = document.querySelector("#txtparametro").value;
        let strvalor = document.querySelector("#txtvalor").value;

        if (strparametro == "" || strvalor == "") {
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
        let ajaxUrl = base_url + "/Parametros/setParametro";
        let formData = new FormData(formParametros);
        request.open("POST", ajaxUrl, true);
        request.send(formData);
        request.onreadystatechange = function () {
          if (request.readyState == 4 && request.status == 200) {
            let objData = JSON.parse(request.responseText);
            if (objData.status) {
              if (rowTable == "") {
                tableParametros.api().ajax.reload();
              } else {
                // htmlStatus =
                //   intStatus == 1
                //     ? '<span class="badge badge-success">ACTIVO</span>'
                //     : intStatus == 3
                //     ? '<span class="badge badge-info">NUEVO</span>'
                //     : intStatus == 4
                //     ? '<span class="badge badge-danger">BLOQUEADO</span>'
                //     : '<span class="badge badge-danger">INACTIVO</span>';

                rowTable.cells[0].textContent = strparametro;
                rowTable.cells[1].textContent = strvalor;
                // rowTable.cells[2].textContent = strEmail; PUEDE SER CREADO POR

                rowTable = "";
              }

              $("#modalFormParametros").modal("hide");

              formParametros.reset();
              swal("Parametros", objData.msg, "success");
            } else {
              swal("Error", objData.msg, "error");
            }
          }
          divLoading.style.display = "none";
          return false;
        };
      };
    }
  }, //ESTEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
  false
);

// window.addEventListener(
//   "load",
//   function () {
//     fntRolesUsuario();
//   },
//   false
// );

// function fntRolesUsuario() {
//   if (document.querySelector("#listid_rol")) {
//     let ajaxUrl = base_url + "/Roles/getSelectRoles";
//     let request = window.XMLHttpRequest
//       ? new XMLHttpRequest()
//       : new ActiveXObject("Microsoft.XMLHTTP");
//     request.open("GET", ajaxUrl, true);
//     request.send();
//     request.onreadystatechange = function () {
//       if (request.readyState == 4 && request.status == 200) {
//         document.querySelector("#listid_rol").innerHTML = request.responseText;
//         $("#listid_rol").selectpicker("render");
//       }
//     };
//   }
// }

// function fntViewUsuario(id_usuario) {
//   let request = window.XMLHttpRequest
//     ? new XMLHttpRequest()
//     : new ActiveXObject("Microsoft.XMLHTTP");
//   let ajaxUrl = base_url + "/Usuarios/getUsuario/" + id_usuario;
//   request.open("GET", ajaxUrl, true);
//   request.send();
//   request.onreadystatechange = function () {
//     if (request.readyState == 4 && request.status == 200) {
//       let objData = JSON.parse(request.responseText);

//       if (objData.status) {
//         let estadoUsuario =
//           objData.data.estado == 1
//             ? '<span class="badge badge-success">ACTIVO</span>'
//             : objData.data.estado == 3
//             ? '<span class="badge badge-info">NUEVO</span>'
//             : '<span class="badge badge-danger">INACTIVO</span>';

//         document.querySelector("#celusuario").innerHTML = objData.data.usuario;
//         document.querySelector("#celNombre").innerHTML =
//           objData.data.nombre_usuario;
//         document.querySelector("#celpreguntas_contestadas").innerHTML =
//           objData.data.preguntas_contestadas;
//         document.querySelector("#celEmail").innerHTML =
//           objData.data.correo_electronico;
//         document.querySelector("#celTipoUsuario").innerHTML =
//           objData.data.nombrerol;
//         document.querySelector("#celEstado").innerHTML = estadoUsuario;
//         document.querySelector("#celCreadoPor").innerHTML =
//           objData.data.creado_por;
//         document.querySelector("#celFechaRegistro").innerHTML =
//           objData.data.fechaRegistro;
//         document.querySelector("#celModificadoPor").innerHTML =
//           objData.data.modificado_por;
//         document.querySelector("#celFechaModificacion").innerHTML =
//           objData.data.fecha_modificacion;

//         $("#modalViewUser").modal("show");
//       } else {
//         swal("Error", objData.msg, "error");
//       }
//     }
//   };
// }

//Función cuando se le da click al botón editar Parámetro
function fntEditParametro(element, id_parametro) {
  rowTable = element.parentNode.parentNode.parentNode;
  document.querySelector("#titleModal").innerHTML = "Actualizar Parametro";
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
  let ajaxUrl = base_url + "/Parametros/getParametro/" + id_parametro;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      let objData = JSON.parse(request.responseText);

      if (objData.status) {
        document.querySelector("#id_parametro").value =
          objData.data.id_parametro;

        document.querySelector("#txtparametro").value = objData.data.parametro;
        document.querySelector("#txtvalor").value = objData.data.valor;

        //Si recibe un usuario, quiere decir que está editando,
        //entonces coloca el input de Usuario como solo lectura
        // if (id_usuario) {
        //   document.querySelector("#txtusuario").setAttribute("readonly", true);
        // }

        // document.querySelector("#txtnombre_usuario").value =
        //   objData.data.nombre_usuario;
        // document.querySelector("#txtEmail").value =
        //   objData.data.correo_electronico;
        // document.querySelector("#listid_rol").value = objData.data.id_rol;
        // $("#listid_rol").selectpicker("render");

        // if (objData.data.estado == 1) {
        //   document.querySelector("#listStatus").value = 1;
        // } else if (objData.data.estado == 2) {
        //   document.querySelector("#listStatus").value = 2;
        // } else {
        //   document.querySelector("#listStatus").value = 3;
        // }

        // $("#listStatus").selectpicker("render");
      }
    }

    $("#modalFormParametros").modal("show");
  };
}

function fntDelParametro(id_parametro) {
  swal(
    {
      title: "Eliminar Parametro",
      text: "¿Realmente quiere eliminar el Parametro?",
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
        let ajaxUrl = base_url + "/Parametros/delParametro";
        let strData = "id_parametro=" + id_parametro;
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
              tableParametros.api().ajax.reload();
            } else {
              swal("Atención!", objData.msg, "error");
            }
          }
        };
      }
    }
  );
}

//Abre el modal para agregar parametro
function openModal() {
  rowTable = "";
  document.querySelector("#id_parametro").value = "";
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
  document.querySelector("#titleModal").innerHTML = "Nuevo Parametro";
  document.querySelector("#formParametros").reset();
  //$("#listStatus").prop("disabled", true);
  //$("#listStatus").val("3");

  $("#modalFormParametros").modal("show");
}
