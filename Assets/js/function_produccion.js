let tableProduccion;
let rowTable = "";
let divLoading = document.querySelector("#divLoading");
document.addEventListener(
  "DOMContentLoaded",
  function () {
    tableProduccion = $("#tableProduccion").dataTable({
      aProcessing: true,
      aServerSide: true,
      language: {
        url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json",
      },
      ajax: {
        url: " " + base_url + "/Produccion/getProduccion",
        dataSrc: "",
      },
      columns: [
        { data: "nombre_producto" },
        { data: "cantidad" },
        { data: "fecha" },
        { data: "nombre_usuario" },
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
                  text: "REPORTE DE PRODUCCIÓN",
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
  },
  false
);

function fntDelProduccion(cod_produccion) {
  swal(
    {
      title: "Anular Produccion",
      text: "¿Realmente quiere anular la produccion?",
      type: "warning",
      showCancelButton: true,
      confirmButtonText: "ANULAR",
      cancelButtonText: "CANCELAR",
      closeOnConfirm: false,
      closeOnCancel: true,
    },
    function (isConfirm) {
      if (isConfirm) {
        let request = window.XMLHttpRequest
          ? new XMLHttpRequest()
          : new ActiveXObject("Microsoft.XMLHTTP");
        let ajaxUrl = base_url + "/Produccion/delProduccion";
        let strData = "cod_produccion=" + cod_produccion;
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
              swal("Anular!", objData.msg, "success");
              tableProduccion.api().ajax.reload();
            } else if (objData.statusReferencial) {
              swal("Atención!", objData.msg, "error");
              tableProduccion.api().ajax.reload();
            } else {
              swal("Atención!", objData.msg, "error");
            }
          }
        };
      }
    }
  );
}
function fntDelProduccionP(cod_produccion) {
  swal(
    {
      title: "Anular Produccion",
      text: "¿Realmente quiere anular la producción con pérdida?",
      type: "warning",
      showCancelButton: true,
      confirmButtonText: "ANULAR",
      cancelButtonText: "CANCELAR",
      closeOnConfirm: false,
      closeOnCancel: true,
    },
    function (isConfirm) {
      if (isConfirm) {
        let request = window.XMLHttpRequest
          ? new XMLHttpRequest()
          : new ActiveXObject("Microsoft.XMLHTTP");
        let ajaxUrl = base_url + "/Produccion/delProduccionP";
        let strData = "cod_produccion=" + cod_produccion;
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
              swal("Anular!", objData.msg, "success");
              tableProduccion.api().ajax.reload();
            } else if (objData.statusReferencial) {
              swal("Atención!", objData.msg, "error");
              tableProduccion.api().ajax.reload();
            } else {
              swal("Atención!", objData.msg, "error");
            }
          }
        };
      }
    }
  );
}
function fntFinProduccion(cod_produccion, cantidad, cod_producto) {
  swal(
    {
      title: "Finalizar Produccion",
      text: "¿Realmente quiere finalizar la producción?",
      type: "warning",
      showCancelButton: true,
      confirmButtonText: "FINALIZAR",
      cancelButtonText: "CANCELAR",
      closeOnConfirm: false,
      closeOnCancel: true,
    },
    function (isConfirm) {
      if (isConfirm) {
        let request = window.XMLHttpRequest
          ? new XMLHttpRequest()
          : new ActiveXObject("Microsoft.XMLHTTP");
        let ajaxUrl = base_url + "/Produccion/finProduccion";
        let strData =
          "cod_produccion=" +
          cod_produccion +
          "&cantidad=" +
          cantidad +
          "&cod_producto=" +
          cod_producto;

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
              swal("Finalizar!", objData.msg, "success");
              tableProduccion.api().ajax.reload();
            } else if (objData.statusReferencial) {
              swal("Atención!", objData.msg, "error");
              tableProduccion.api().ajax.reload();
            } else {
              swal("Atención!", objData.msg, "error");
            }
          }
        };
      }
    }
  );
}

function ver_produccion(codProduccion) {
  var cod_produccion = codProduccion;
  // var cod_factura = codFactura;

  generarPDF(cod_produccion);
}

function generarPDF(produccion) {
  var ancho = 1000;
  var alto = 800;
  //Calcular posicion x,y para centrar la ventana
  var x = parseInt(window.screen.width / 2 - ancho / 2);
  var y = parseInt(window.screen.height / 2 - alto / 2);

  $url = "Views/nueva_produccion/factura/generaFactura.php?f=" + produccion;
  window.open(
    $url,
    "Factura",
    "left=" +
      x +
      ",top=" +
      y +
      ",height=" +
      alto +
      ",width=" +
      ancho +
      ",scrollbar=si,location=no,resizable=si,menubar=no"
  );
}
