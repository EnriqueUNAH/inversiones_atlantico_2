let tableProveedores;
let rowTable = "";
let divLoading = document.querySelector("#divLoading");
document.addEventListener(
  "DOMContentLoaded",
  function () {
    tableProveedores = $("#tableProveedores").dataTable({
      aProcessing: true,
      aServerSide: true,
      language: {
        url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json",
      },
      ajax: {
        url: " " + base_url + "/Proveedores/getProveedores",
        dataSrc: "",
      },
      columns: [
        {
          data: "rtn",
          // render: function (data, type, row) {
          //   if (data == 0) {
          //     return "";
          //   } else {
          //     return data;
          //   }
          // },
        },
        { data: "nombres" },
        {
          data: "telefono",
          render: function (data, type, row) {
            if (data === 0) {
              return "";
            } else {
              return data;
            }
          },
        },
        { data: "correo_electronico" },
        { data: "direccion" },
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
            columns: [0, 1, 2, 3, 4],
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
                  text: "REPORTE DE PROVEEDORES",
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
            columns: [0, 1, 2, 3, 4],
          },
        },
      ],
      resonsieve: "true",
      bDestroy: true,
      iDisplayLength: 10,
      order: [[0, "desc"]],
    });

    if (document.querySelector("#formProveedor")) {
      let formProveedor = document.querySelector("#formProveedor");
      formProveedor.onsubmit = function (e) {
        e.preventDefault();

        let strRtn = document.querySelector("#txtRtn").value;
        let strNombres = document
          .querySelector("#txtNombres")
          .value.toUpperCase();
        let intTelefono = document.querySelector("#txtTelefono").value;
        let strEmail = document.querySelector("#txtEmail").value;
        let strDireccion = document
          .querySelector("#txtDireccion")
          .value.toUpperCase();

        if (strNombres == "") {
          swal("Atención", "Los campos con * son obligatorios.", "error");
          return false;
        } else if (strRtn.length < 14) {
          swal("Atención", "Rtn Tiene que contener 14 digitos", "error");
          return false;
        } else if (strRtn == 00000000000000) {
          swal("Atención", "Rtn no puede ser 0", "error");
          return false;
        } else if (intTelefono.length < 8) {
          swal("Atención", "Teléfono Tiene que contener 8 digitos", "error");
          return false;
        } else if (intTelefono == 00000000) {
          swal("Atención", "Teléfono no puede ser 0", "error");
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
        let ajaxUrl = base_url + "/Proveedores/setProveedor";
        let formData = new FormData(formProveedor);
        request.open("POST", ajaxUrl, true);
        request.send(formData);
        request.onreadystatechange = function () {
          if (request.readyState == 4 && request.status == 200) {
            let objData = JSON.parse(request.responseText);
            if (objData.status) {
              if (rowTable == "") {
                tableProveedores.api().ajax.reload();
              } else {
                rowTable.cells[0].textContent = strRtn;
                rowTable.cells[1].textContent = strNombres;
                rowTable.cells[2].textContent = intTelefono;
                rowTable.cells[3].textContent = strEmail;
                rowTable.cells[4].innerHTML = strDireccion;
                rowTable = "";
              }

              $("#modalFormProveedor").modal("hide");

              formProveedor.reset();
              swal("Proveedores", objData.msg, "success");
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

// window.addEventListener(
//   "load",
//   function () {
//     fntGeneroProveedor();
//   },
//   false
// );

// function fntGeneroProveedor() {
//   if (document.querySelector("#listGenero")) {
//     let ajaxUrl = base_url + "/Proveedores/getSelectGenero";
//     let request = window.XMLHttpRequest
//       ? new XMLHttpRequest()
//       : new ActiveXObject("Microsoft.XMLHTTP");
//     request.open("GET", ajaxUrl, true);
//     request.send();
//     request.onreadystatechange = function () {
//       if (request.readyState == 4 && request.status == 200) {
//         document.querySelector("#listGenero").innerHTML = request.responseText;
//         $("#listGenero").selectpicker("render");
//       }
//     };
//   }
// }

function fntViewProveedor(cod_proveedor) {
  let request = window.XMLHttpRequest
    ? new XMLHttpRequest()
    : new ActiveXObject("Microsoft.XMLHTTP");
  let ajaxUrl = base_url + "/Proveedores/getProveedor/" + cod_proveedor;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      let objData = JSON.parse(request.responseText);

      if (objData.status) {
        // let estadoUsuario =
        //   objData.data.estado == 1
        //     ? '<span class="badge badge-success">ACTIVO</span>'
        //     : objData.data.estado == 3
        //     ? '<span class="badge badge-info">NUEVO</span>'
        //     : '<span class="badge badge-danger">INACTIVO</span>';

        document.querySelector("#celRtn").innerHTML = objData.data.rtn;
        document.querySelector("#celNombres").innerHTML = objData.data.nombres;
        document.querySelector("#celTelefono").innerHTML =
          objData.data.telefono;
        document.querySelector("#celEmail").innerHTML =
          objData.data.correo_electronico;
        document.querySelector("#celDireccion").innerHTML =
          objData.data.direccion;
        // document.querySelector("#celGenero").innerHTML =
        //   objData.data.nombre_genero;
        document.querySelector("#celCreadoPor").innerHTML =
          objData.data.creado_por;
        document.querySelector("#celFechaCreacion").innerHTML =
          objData.data.fecha_creacion;
        document.querySelector("#celModificadoPor").innerHTML =
          objData.data.modificado_por;
        document.querySelector("#celFechaModificacion").innerHTML =
          objData.data.fecha_modificacion;

        $("#modalViewProveedor").modal("show");
      } else {
        swal("Error", objData.msg, "error");
      }
    }
  };
}

//Función cuando se le da click al botón editar proveedor probar
function fntEditProveedor(element, cod_proveedor) {
  rowTable = element.parentNode.parentNode.parentNode;
  document.querySelector("#titleModal").innerHTML = "Actualizar Proveedor";
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
  let ajaxUrl = base_url + "/Proveedores/getProveedor/" + cod_proveedor;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      let objData = JSON.parse(request.responseText);

      if (objData.status) {
        document.querySelector("#cod_proveedor").value =
          objData.data.cod_proveedor;
        document.querySelector("#txtRtn").value = objData.data.rtn;
        document.querySelector("#txtNombres").value = objData.data.nombres;
        document.querySelector("#txtTelefono").value = objData.data.telefono;
        document.querySelector("#txtEmail").value =
          objData.data.correo_electronico;
        document.querySelector("#txtDireccion").value = objData.data.direccion;
        // document.querySelector("#listGenero").value = objData.data.cod_genero;
        // $("#listGenero").selectpicker("render");
      }
    }
    $("#modalFormProveedor").modal("show");
  };
}

function fntDelProveedor(cod_proveedor) {
  swal(
    {
      title: "Eliminar Proveedor",
      text: "¿Realmente quiere eliminar el Proveedor?",
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
        let ajaxUrl = base_url + "/Proveedores/delProveedor";
        let strData = "cod_proveedor=" + cod_proveedor;
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
              tableProveedores.api().ajax.reload();
            } else if (objData.statusReferencial) {
              swal("Atención!", objData.msg, "error");
              tableProveedores.api().ajax.reload();
            } else {
              swal("Atención!", objData.msg, "error");
            }
          }
        };
      }
    }
  );
}

//Abre el modal para agregar proveedor
function openModal() {
  rowTable = "";
  document.querySelector("#cod_proveedor").value = "";
  //document.querySelector("#txtusuario").removeAttribute("readonly"); //Para quitar el readonly en caso de que antes se haya editado

  document
    .querySelector(".modal-header")
    .classList.replace("headerUpdate", "headerRegister");
  document
    .querySelector("#btnActionForm")
    .classList.replace("btn-info", "btn-primary");
  document.querySelector("#btnText").innerHTML = "Guardar";
  document.querySelector("#titleModal").innerHTML = "Nuevo Proveedor";
  document.querySelector("#formProveedor").reset();

  $("#modalFormProveedor").modal("show");
}