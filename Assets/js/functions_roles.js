var tableRoles;
var divLoading = document.querySelector("#divLoading");
document.addEventListener("DOMContentLoaded", function () {
  tableRoles = $("#tableRoles").dataTable({
    aProcessing: true,
    aServerSide: true,
    language: {
      url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json",
    },
    ajax: {
      url: " " + base_url + "/Roles/getRoles",
      dataSrc: "",
    },
    columns: [
      { data: "nombrerol" },
      { data: "descripcion" },
      { data: "estado" },
      { data: "options" },
    ],

    dom: "lBfrtip",
    buttons: [
      {
        extend: "pdfHtml5",
        download: "open",
        title: "INVERSIONES DEL ATLÁNTICO",
        text: "<i class='fas fa-file-pdf'></i> PDF",
        titleAttr: "Exportar a PDF",
        className: "btn btn-danger",
        exportOptions: {
          columns: [0, 1, 2],
        },
        customize: function (doc) {
          doc.styles.tableHeader.alignment = "left"; //Alineación de los nombres de columnas.
          doc.defaultStyle.alignment = "left"; //Alineación de los datos de la tabla.
          //Para separar las columnas.
          doc.content[1].layout = {
            hLineWidth: function (i, node) {
              return 1; // ancho de la línea en píxeles
            },
            vLineWidth: function (i, node) {
              return 1;
            },
            hLineColor: function (i, node) {
              return "#aaa"; // color de la línea
            },
            vLineColor: function (i, node) {
              return "#aaa";
            },
          };

          doc.styles.tableHeader.color = "#ffffff";
          doc.styles.tableHeader.fillColor = "#007bff";
          doc.styles.tableBodyEven.fillColor = "#f2f2f2";
          doc.styles.tableBodyOdd.fillColor = "#ffffff";
          doc.content[1].table.widths = Array(
            doc.content[1].table.body[0].length + 1
          )
            .join("*")
            .split("");

          doc.content.splice(1, 0, {
            columns: [
              {
                text: "REPORTE DE ROLES",
                fontsize: 20,
                bold: true,
                alignment: "center",
                margin: [0, 0, 0, 15],
                width: "*",
              },
            ],
          });

          // Agregar pie de página con la fecha
          var now = new Date();
          var date = now.toLocaleDateString();
          var time = now.toLocaleTimeString();
          var dateTime = date + " " + time;
          var pageCount = 0;
          if (doc && doc.internal) {
            pageCount = doc.internal.getNumberOfPages();
          }
          doc.pageCount = pageCount;
          doc.footer = function (currentPage, pageCount) {
            return {
              text:
                "Fecha: " +
                dateTime +
                " - Página " +
                currentPage +
                " de " +
                pageCount,
              alignment: "center",
            };
          };
          // Crear el PDF con pdfMake
          var pdfDoc = pdfMake.createPdf(doc);

          // Mostrar el PDF en una nueva pestaña del navegador
          // pdfDoc.getBlob(function (blob) {
          //   var objectUrl = URL.createObjectURL(blob);
          //   window.open(objectUrl);
          // });
        },
      },
      {
        extend: "excelHtml5",
        text: "<i class='fas fa-file-excel'></i> Excel",
        titleAttr: "Exportar a Excel",
        className: "btn btn-success",
        exportOptions: {
          columns: [0, 1, 2],
        },
      },
    ],

    resonsieve: "true",
    bDestroy: true,
    iDisplayLength: 10,
    order: [[0, "desc"]],
  });

  //NUEVO ROL
  var formRol = document.querySelector("#formRol");
  formRol.onsubmit = function (e) {
    e.preventDefault();

    var intid_rol = document.querySelector("#id_rol").value;
    var strNombre = document.querySelector("#txtNombre").value.toUpperCase();
    var strDescripcion = document
      .querySelector("#txtDescripcion")
      .value.toUpperCase();
    var intestado = document.querySelector("#listStatus").value;
    if (strNombre == "" || strDescripcion == "" || intestado == "") {
      swal("Atención", "Todos los campos son obligatorios.", "error");
      return false;
    }
    divLoading.style.display = "flex";
    var request = window.XMLHttpRequest
      ? new XMLHttpRequest()
      : new ActiveXObject("Microsoft.XMLHTTP");
    var ajaxUrl = base_url + "/Roles/setRol";
    var formData = new FormData(formRol);
    request.open("POST", ajaxUrl, true);
    request.send(formData);
    request.onreadystatechange = function () {
      if (request.readyState == 4 && request.status == 200) {
        var objData = JSON.parse(request.responseText);
        if (objData.status) {
          $("#modalFormRol").modal("hide");
          formRol.reset();
          swal("Roles de usuario", objData.msg, "success");
          tableRoles.api().ajax.reload();
        } else {
          swal("Error", objData.msg, "error");
        }
      }
      divLoading.style.display = "none";
      return false;
    };
  };
});

$("#tableRoles").DataTable();

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

window.addEventListener(
  "load",
  function () {
    /*
    fntEditRol();
    fntDelRol();
    fntPermisos();
    */
  },
  false
);

function fntEditRol(id_rol) {
  document.querySelector("#titleModal").innerHTML = "Actualizar Rol";
  document
    .querySelector(".modal-header")
    .classList.replace("headerRegister", "headerUpdate");
  document
    .querySelector("#btnActionForm")
    .classList.replace("btn-primary", "btn-info");
  document.querySelector("#btnText").innerHTML = "Actualizar";

  var id_rol = id_rol;
  var request = window.XMLHttpRequest
    ? new XMLHttpRequest()
    : new ActiveXObject("Microsoft.XMLHTTP");
  var ajaxUrl = base_url + "/Roles/getRol/" + id_rol;
  request.open("GET", ajaxUrl, true);
  request.send();

  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      var objData = JSON.parse(request.responseText);
      if (objData.status) {
        document.querySelector("#id_rol").value = objData.data.id_rol;
        document.querySelector("#txtNombre").value = objData.data.nombrerol;
        document.querySelector("#txtDescripcion").value =
          objData.data.descripcion;

        if (objData.data.status == 1) {
          var optionSelect =
            '<option value="1" selected class="notBlock">ACTIVO</option>';
        } else {
          var optionSelect =
            '<option value="2" selected class="notBlock">INACTIVO</option>';
        }
        var htmlSelect = `${optionSelect}
                                  <option value="1">ACTIVO</option>
                                  <option value="2">INACTIVO</option>
                                `;
        document.querySelector("#listStatus").innerHTML = htmlSelect;
        $("#modalFormRol").modal("show");
      } else {
        swal("Error", objData.msg, "error");
      }
    }
  };
}

function fntDelRol(id_rol) {
  var id_rol = id_rol;
  swal(
    {
      title: "Eliminar Rol",
      text: "¿Realmente quiere eliminar el Rol?",
      type: "warning",
      showCancelButton: true,
      confirmButtonText: "ELIMINAR",
      cancelButtonText: "CANCELAR",
      closeOnConfirm: false,
      closeOnCancel: true,
    },
    function (isConfirm) {
      if (isConfirm) {
        var request = window.XMLHttpRequest
          ? new XMLHttpRequest()
          : new ActiveXObject("Microsoft.XMLHTTP");
        var ajaxUrl = base_url + "/Roles/delRol/";
        var strData = "id_rol=" + id_rol;
        request.open("POST", ajaxUrl, true);
        request.setRequestHeader(
          "Content-type",
          "application/x-www-form-urlencoded"
        );
        request.send(strData);
        request.onreadystatechange = function () {
          if (request.readyState == 4 && request.status == 200) {
            var objData = JSON.parse(request.responseText);
            if (objData.status) {
              swal("Eliminar!", objData.msg, "success");
              tableRoles.api().ajax.reload(function () {
                /*
                fntEditRol();
                fntDelRol();
                fntPermisos();
*/
              });
            } else {
              swal("Atención!", objData.msg, "error");
            }
          }
        };
      }
    }
  );
}

function fntPermisos(id_rol) {
  var id_rol = id_rol;
  var request = window.XMLHttpRequest
    ? new XMLHttpRequest()
    : new ActiveXObject("Microsoft.XMLHTTP");
  var ajaxUrl = base_url + "/Permisos/getPermisosRol/" + id_rol;
  request.open("GET", ajaxUrl, true);
  request.send();

  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      document.querySelector("#contentAjax").innerHTML = request.responseText;
      $(".modalPermisos").modal("show");
      document
        .querySelector("#formPermisos")
        .addEventListener("submit", fntSavePermisos, false);
    }
  };
}

function fntSavePermisos(evnet) {
  evnet.preventDefault();
  var request = window.XMLHttpRequest
    ? new XMLHttpRequest()
    : new ActiveXObject("Microsoft.XMLHTTP");
  var ajaxUrl = base_url + "/Permisos/setPermisos";
  var formElement = document.querySelector("#formPermisos");
  var formData = new FormData(formElement);
  request.open("POST", ajaxUrl, true);
  request.send(formData);

  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      var objData = JSON.parse(request.responseText);
      if (objData.status) {
        swal("Permisos de usuario", objData.msg, "success");
      } else {
        swal("Error", objData.msg, "error");
      }
    }
  };
}
