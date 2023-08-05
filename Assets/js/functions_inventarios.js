let tableInventarios;
let rowTable = "";
let divLoading = document.querySelector("#divLoading");
document.addEventListener(
  "DOMContentLoaded",
  function () {
    tableInventarios = $("#tableInventarios").dataTable({
      aProcessing: true,
      aServerSide: true,
      language: {
        url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json",
      },
      ajax: {
        url: " " + base_url + "/Inventarios/getInventarios",
        dataSrc: "",
      },
      columns: [
        { data: "nombre_producto" },
        { data: "nombre_tipo_producto" },
        { data: "existencia" },
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
                  text: "REPORTE DE INVENTARIOS",
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
  },
  false
);

function ver_inventario(codInventario) {
  var cod_inventario = codInventario;
  // var cod_factura = codFactura;

  generarPDF(cod_inventario);
}

function generarPDF(inventario) {
  var ancho = 1000;
  var alto = 800;
  //Calcular posicion x,y para centrar la ventana
  var x = parseInt(window.screen.width / 2 - ancho / 2);
  var y = parseInt(window.screen.height / 2 - alto / 2);

  $url = "Views/inventario/factura/generaFactura.php?f=" + inventario;
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
