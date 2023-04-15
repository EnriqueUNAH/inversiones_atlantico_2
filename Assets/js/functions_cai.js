let tableCai;
let rowTable = "";
let divLoading = document.querySelector("#divLoading");
document.addEventListener(
  "DOMContentLoaded",
  function () {
    tableCai = $("#tableCai").dataTable({
      aProcessing: true,
      aServerSide: true,
      language: {
        url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json",
      },
      ajax: {
        url: " " + base_url + "/Cai/getCais",
        dataSrc: "",
      },
      columns: [
        { data: "rango_inicial" },
        { data: "rango_final" },
        { data: "rango_actual" },
        { data: "numero_CAI" },
        { data: "fecha_vencimiento" },
        { data: "usuario" },
        { data: "estado" },
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
            columns: [0, 1, 2, 3, 4, 5],
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

    if (document.querySelector("#formCai")) {
      let formCai = document.querySelector("#formCai");
      formCai.onsubmit = function (e) {
        e.preventDefault();

        let intRangoI = document.querySelector("#txtRangoI").value;
        let intRangoF = document.querySelector("#txtRangoF").value;
        // let intRangoA = document.querySelector("#rango_actual").value;
        let intNum = document.querySelector("#txtnum").value;
        let dateFechaVenc = document.querySelector("#txtFecha").value;

        if (
          intRangoI == "" ||
          intRangoF == "" ||
          intNum == "" ||
          dateFechaVenc == ""
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
        let ajaxUrl = base_url + "/Cai/setCai";
        let formData = new FormData(formCai);
        request.open("POST", ajaxUrl, true);
        request.send(formData);
        request.onreadystatechange = function () {
          if (request.readyState == 4 && request.status == 200) {
            let objData = JSON.parse(request.responseText);
            if (objData.status) {
              if (rowTable == "") {
                tableCai.api().ajax.reload();
              } else {
                rowTable.cells[0].textContent = intRangoI;
                rowTable.cells[1].textContent = intRangoF;
                // rowTable.cells[2].textContent = intRangoA;
                rowTable.cells[3].textContent = intNum;
                rowTable.cells[4].textContent = dateFechaVenc;
                rowTable.cells[5].textContent = estado;

                rowTable = "";
              }

              $("#modalFormCai").modal("hide");

              formCai.reset();
              swal("Cai", objData.msg, "success");
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

//Función cuando se le da click al botón editar Parámetro
function fntEditCai(element, cod_talonario) {
  rowTable = element.parentNode.parentNode.parentNode;
  document.querySelector("#titleModal").innerHTML = "Actualizar CAI";
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
  let ajaxUrl = base_url + "/Cai/getCai/" + cod_talonario;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      let objData = JSON.parse(request.responseText);

      if (objData.status) {
        document.querySelector("#cod_talonario").value =
          objData.data.cod_talonario;
        document.querySelector("#txtRangoI").value = objData.data.rango_inicial;
        document.querySelector("#txtRangoF").value = objData.data.rango_final;
        // document.querySelector("#txtRangoA").value = objData.data.rango_actual;
        document.querySelector("#txtnum").value = objData.data.numero_CAI;
        document.querySelector("#txtFecha").value =
          objData.data.fecha_vencimiento;
      }
    }

    $("#modalFormCai").modal("show");
  };
}

function fntDelCai(cod_talonario) {
  swal(
    {
      title: "Eliminar CAI",
      text: "¿Realmente quiere eliminar el CAI?",
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
        let ajaxUrl = base_url + "/Cai/delCai";
        let strData = "cod_talonario=" + cod_talonario;
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
              tableCai.api().ajax.reload();
            } else {
              swal("Atención!", objData.msg, "error");
            }
          }
        };
      }
    }
  );
}

//Abre el modal para agregar cai
function openModal() {
  rowTable = "";
  document.querySelector("#cod_talonario").value = "";
  document
    .querySelector(".modal-header")
    .classList.replace("headerUpdate", "headerRegister");
  document
    .querySelector("#btnActionForm")
    .classList.replace("btn-info", "btn-primary");
  document.querySelector("#btnText").innerHTML = "Guardar";
  document.querySelector("#titleModal").innerHTML = "Nuevo CAI";
  document.querySelector("#formCai").reset();

  $("#modalFormCai").modal("show");
}

$(document).ready(function () {
  $("#txtRangoI").inputmask("999-999-99-99999999");
});
$(document).ready(function () {
  $("#txtRangoF").inputmask("999-999-99-99999999");
});
$(document).ready(function () {
  $("#txtnum").inputmask("******-******-******-******-******-**");
});
