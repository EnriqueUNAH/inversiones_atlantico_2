let tableDescuentos;
let rowTable = "";
let divLoading = document.querySelector("#divLoading");
document.addEventListener(
  "DOMContentLoaded",
  function () {
    tableDescuentos = $("#tableDescuentos").dataTable({
      aProcessing: true,
      aServerSide: true,
      language: {
        url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json",
      },
      ajax: {
        url: " " + base_url + "/Descuentos/getDescuentos",
        dataSrc: "",
      },
      columns: [
        { data: "nombre_descuento" },
        { data: "porcentaje_descuento" },
        { data: "options" },
      ],
      dom: "lBfrtip",
      buttons: [
        {
          extend: "pdfHtml5",
          text: "<i class='fas fa-file-pdf'></i> PDF",
          titleAttr: "Exportar a PDF",
          className: "btn btn-danger",
          exportOptions: {
            columns: [0, 1],
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
            pdfDoc.getBlob(function (blob) {
              var objectUrl = URL.createObjectURL(blob);
              window.open(objectUrl);
            });
          },
        },
      ],
      resonsieve: "true",
      bDestroy: true,
      iDisplayLength: 10,
      order: [[0, "desc"]],
    });

    if (document.querySelector("#formDescuento")) {
      let formDescuento = document.querySelector("#formDescuento");
      formDescuento.onsubmit = function (e) {
        e.preventDefault();
        // let intIdCodigo = document.querySelector("#txtIdCodigo").value;
        let strNombre = document
          .querySelector("#txtNombre")
          .value.toUpperCase();
        let intPorcentaje = document.querySelector("#txtPorcentaje").value;

        if (strNombre == "" || intPorcentaje == "") {
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
        let ajaxUrl = base_url + "/Descuentos/setDescuento";
        let formData = new FormData(formDescuento);
        request.open("POST", ajaxUrl, true);
        request.send(formData);
        request.onreadystatechange = function () {
          if (request.readyState == 4 && request.status == 200) {
            let objData = JSON.parse(request.responseText);
            if (objData.status) {
              if (rowTable == "") {
                tableDescuentos.api().ajax.reload();
              } else {
                rowTable.cells[0].textContent = strNombre;
                rowTable.cells[1].textContent = intPorcentaje;
                rowTable = "";
              }
              $("#modalFormDescuentos").modal("hide");
              formDescuento.reset();
              swal("Descuento", objData.msg, "success");
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

function fntViewInfo(cod_descuento) {
  let request = window.XMLHttpRequest
    ? new XMLHttpRequest()
    : new ActiveXObject("Microsoft.XMLHTTP");
  let ajaxUrl = base_url + "/Descuentos/getDescuento/" + cod_descuento;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      let objData = JSON.parse(request.responseText);
      if (objData.status) {
        document.querySelector("#txtIdCodigo").innerHTML =
          objData.data.cod_descuento;
        document.querySelector("#txtNombre").innerHTML = objData.data.nombre;
        document.querySelector("#txtPorcentaje").innerHTML =
          objData.data.porcentaje;
        $("#modalViewDescuento").modal("show");
      } else {
        swal("Error", objData.msg, "error");
      }
    }
  };
}

function fntEditInfo(element, cod_descuento) {
  rowTable = element.parentNode.parentNode.parentNode;
  document.querySelector("#titleModal").innerHTML = "Actualizar Descuento";
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
  let ajaxUrl = base_url + "/Descuentos/getDescuento/" + cod_descuento;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      let objData = JSON.parse(request.responseText);
      if (objData.status) {
        // document.querySelector("#idUsuario").value = objData.data.idpersona;
        document.querySelector("#cod_descuento").value =
          objData.data.cod_descuento;
        document.querySelector("#txtNombre").value =
          objData.data.nombre_descuento;
        document.querySelector("#txtPorcentaje").value =
          objData.data.porcentaje_descuento;
      }
    }
    $("#modalFormDescuentos").modal("show");
  };
}

function fntDelInfo(cod_descuento) {
  swal(
    {
      title: "Eliminar Descuento",
      text: "¿Realmente quiere eliminar el descuento?",
      type: "warning",
      showCancelButton: true,
      confirmButtonText: "Si, eliminar!",
      cancelButtonText: "No, cancelar!",
      closeOnConfirm: false,
      closeOnCancel: true,
    },
    function (isConfirm) {
      if (isConfirm) {
        let request = window.XMLHttpRequest
          ? new XMLHttpRequest()
          : new ActiveXObject("Microsoft.XMLHTTP");
        let ajaxUrl = base_url + "/Descuentos/delDescuento";
        let strData = "cod_descuento=" + cod_descuento;
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
              swal("Atención!", objData.msg, "error");
            } else {
              swal("Eliminar!", objData.msg, "success");
              tableDescuentos.api().ajax.reload();
            }
          }
        };
      }
    }
  );
}

function openModal() {
  rowTable = "";
  document.querySelector("#cod_descuento").value = "";
  document
    .querySelector(".modal-header")
    .classList.replace("headerUpdate", "headerRegister");
  document
    .querySelector("#btnActionForm")
    .classList.replace("btn-info", "btn-primary");
  document.querySelector("#btnText").innerHTML = "Guardar";
  document.querySelector("#titleModal").innerHTML = "Nuevo Descuento";
  document.querySelector("#formDescuento").reset();
  $("#modalFormDescuentos").modal("show");
}
