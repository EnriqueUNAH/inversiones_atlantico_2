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
        { data: "telefono" },
        { data: "correo_electronico" },
        { data: "direccion" },
        { data: "nombre_genero" },
        { data: "options" },
      ],
      dom: "lBfrtip",
      buttons: [
        {
          extend: "pdfHtml5",
          download: "open",
          title:"INVERSIONES DEL ATLÁNTICO",
          text: "<i class='fas fa-file-pdf'></i> PDF",
          titleAttr: "Exportar a PDF",
          className: "btn btn-danger",
          exportOptions: {
            columns: [0, 1, 2, 3, 4, 5, 6],
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

              doc.content.splice(1,0, {
                columns: [
                  {
                  text: "REPORTE DE CLIENTE",
                  fontsize: 20,
                  bold: true,
                  alignment: "center",
                  margin: [0,0,0,15],
                  width: "*"
                  }
                ]
              })

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
      ],
      resonsieve: "true",
      bDestroy: true,
      iDisplayLength: 10,
      order: [[0, "desc"]],
    });

    if (document.querySelector("#formCliente")) {
      let formCliente = document.querySelector("#formCliente");
      formCliente.onsubmit = function (e) {
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
        let cod_genero = document.querySelector("#listGenero").value;

        if (strRtn == "" ||strNombres == "" || intTelefono == "" ||strEmail == "" ||strDireccion == "" || cod_genero == "") {
          swal("Atención", "Los campos con * son obligatorios.", "error");
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
        let ajaxUrl = base_url + "/Clientes/setCliente";
        let formData = new FormData(formCliente);
        request.open("POST", ajaxUrl, true);
        request.send(formData);
        request.onreadystatechange = function () {
          if (request.readyState == 4 && request.status == 200) {
            let objData = JSON.parse(request.responseText);
            if (objData.status) {
              if (rowTable == "") {
                tableClientes.api().ajax.reload();
              } else {
                rowTable.cells[0].textContent = strRtn;
                rowTable.cells[1].textContent = strNombres;
                rowTable.cells[2].textContent = intTelefono;
                rowTable.cells[3].textContent = strEmail;
                rowTable.cells[4].innerHTML = strDireccion;
                rowTable.cells[5].textContent =
                  document.querySelector("#listGenero").selectedOptions[0].text;
                rowTable = "";
              }

              $("#modalFormCliente").modal("hide");

              formCliente.reset();
              swal("Clientes", objData.msg, "success");
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
    fntGeneroCliente();
  },
  false
);

function fntGeneroCliente() {
  if (document.querySelector("#listGenero")) {
    let ajaxUrl = base_url + "/Clientes/getSelectGenero";
    let request = window.XMLHttpRequest
      ? new XMLHttpRequest()
      : new ActiveXObject("Microsoft.XMLHTTP");
    request.open("GET", ajaxUrl, true);
    request.send();
    request.onreadystatechange = function () {
      if (request.readyState == 4 && request.status == 200) {
        document.querySelector("#listGenero").innerHTML = request.responseText;
        $("#listGenero").selectpicker("render");
      }
    };
  }
}

function fntViewCliente(cod_cliente) {
  let request = window.XMLHttpRequest
    ? new XMLHttpRequest()
    : new ActiveXObject("Microsoft.XMLHTTP");
  let ajaxUrl = base_url + "/Clientes/getCliente/" + cod_cliente;
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
        document.querySelector("#celGenero").innerHTML =
          objData.data.nombre_genero;
        document.querySelector("#celCreadoPor").innerHTML =
          objData.data.creado_por;
        document.querySelector("#celFechaCreacion").innerHTML =
          objData.data.fecha_creacion;
        document.querySelector("#celModificadoPor").innerHTML =
          objData.data.modificado_por;
        document.querySelector("#celFechaModificacion").innerHTML =
          objData.data.fecha_modificacion;

        $("#modalViewCliente").modal("show");
      } else {
        swal("Error", objData.msg, "error");
      }
    }
  };
}

//Función cuando se le da click al botón editar cliente probar
function fntEditCliente(element, cod_cliente) {
  rowTable = element.parentNode.parentNode.parentNode;
  document.querySelector("#titleModal").innerHTML = "Actualizar Cliente";
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
  let ajaxUrl = base_url + "/Clientes/getCliente/" + cod_cliente;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      let objData = JSON.parse(request.responseText);

      if (objData.status) {
        document.querySelector("#cod_cliente").value = objData.data.cod_cliente;
        document.querySelector("#txtRtn").value = objData.data.rtn;
        document.querySelector("#txtNombres").value = objData.data.nombres;
        document.querySelector("#txtTelefono").value = objData.data.telefono;
        document.querySelector("#txtEmail").value =
          objData.data.correo_electronico;
        document.querySelector("#txtDireccion").value = objData.data.direccion;
        document.querySelector("#listGenero").value = objData.data.cod_genero;
        $("#listGenero").selectpicker("render");
      }
    }
    $("#modalFormCliente").modal("show");
  };
}

function fntDelCliente(cod_cliente) {
  swal(
    {
      title: "Eliminar Cliente",
      text: "¿Realmente quiere eliminar el Cliente?",
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
        let ajaxUrl = base_url + "/Clientes/delCliente";
        let strData = "cod_cliente=" + cod_cliente;
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
              tableClientes.api().ajax.reload();
            } else if (objData.statusReferencial) {
              swal("Atención!", objData.msg, "error");
              tableClientes.api().ajax.reload();
            } else {
              swal("Atención!", objData.msg, "error");
            }
          }
        };
      }
    }
  );
}

//Abre el modal para agregar cliente
function openModal() {
  rowTable = "";
  document.querySelector("#cod_cliente").value = "";
  //document.querySelector("#txtusuario").removeAttribute("readonly"); //Para quitar el readonly en caso de que antes se haya editado

  document
    .querySelector(".modal-header")
    .classList.replace("headerUpdate", "headerRegister");
  document
    .querySelector("#btnActionForm")
    .classList.replace("btn-info", "btn-primary");
  document.querySelector("#btnText").innerHTML = "Guardar";
  document.querySelector("#titleModal").innerHTML = "Nuevo Cliente";
  document.querySelector("#formCliente").reset();

  $("#modalFormCliente").modal("show");
}
