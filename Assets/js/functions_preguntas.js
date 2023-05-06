let tablePreguntas;
let rowTable = "";
let divLoading = document.querySelector("#divLoading");
document.addEventListener(
  "DOMContentLoaded",
  function () {
    tablePreguntas = $("#tablePreguntas").dataTable({
      aProcessing: true,
      aServerSide: true,
      language: {
        url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json",
      },
      ajax: {
        url: " " + base_url + "/Preguntas/getPreguntas",
        dataSrc: "",
      },
      columns: [{ data: "pregunta" }, { data: "options" }],
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
            columns: [0],
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
                  text: "REPORTE DE PREGUNTAS",
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
      ],
      resonsieve: "true",
      bDestroy: true,
      iDisplayLength: 10,
      order: [[0, "desc"]],
    });

    if (document.querySelector("#formPreguntas")) {
      letformPreguntas = document.querySelector("#formPreguntas");
      formPreguntas.onsubmit = function (e) {
        e.preventDefault();

        let strpregunta = document
          .querySelector("#txtpregunta")
          .value.toUpperCase();

        if (strpregunta == "") {
          swal("Atención", "Todos los campos son obligatorios.", "error");
          return false;
        }

        // let elementsValid = document.getElementsByClassName("valid");
        // for (let i = 0; i < elementsValid.length; i++) {
        //   if (elementsValid[i].classList.contains("is-invalid")) {
        //     swal(
        //       "Atención",
        //       "Por favor verifique los campos en rojo.",
        //       "error"
        //     );
        //     return false;
        //   }
        // }
        divLoading.style.display = "flex";
        let request = window.XMLHttpRequest
          ? new XMLHttpRequest()
          : new ActiveXObject("Microsoft.XMLHTTP");
        let ajaxUrl = base_url + "/Preguntas/setPreguntas";
        let formData = new FormData(formPreguntas);
        request.open("POST", ajaxUrl, true);
        request.send(formData);
        request.onreadystatechange = function () {
          if (request.readyState == 4 && request.status == 200) {
            let objData = JSON.parse(request.responseText);
            if (objData.status) {
              if (rowTable == "") {
                tablePreguntas.api().ajax.reload();
              } else {
                rowTable.cells[0].textContent = strpregunta;

                rowTable = "";
              }

              $("#modalFormPreguntas").modal("hide");

              formPreguntas.reset();
              swal("Preguntas", objData.msg, "success");
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
function fntEditPreguntas(element, id_pregunta) {
  rowTable = element.parentNode.parentNode.parentNode;
  document.querySelector("#titleModal").innerHTML = "Actualizar Pregunta";
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
  let ajaxUrl = base_url + "/Preguntas/getPregunta/" + id_pregunta;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      let objData = JSON.parse(request.responseText);

      if (objData.status) {
        document.querySelector("#id_pregunta").value = objData.data.id_pregunta;

        document.querySelector("#txtpregunta").value = objData.data.pregunta;

        if (id_pregunta) {
          document.querySelector("#txtpregunta").setAttribute("readonly", true);
        }
      }
    }

    $("#modalFormPreguntas").modal("show");
  };
}

function fntDelPreguntas(id_pregunta) {
  swal(
    {
      title: "Eliminar Pregunta",
      text: "¿Realmente quiere eliminar la pregunta?",
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
        let ajaxUrl = base_url + "/Preguntas/delPreguntas";
        let strData = "id_pregunta=" + id_pregunta;
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
              tablePreguntas.api().ajax.reload();
            } else if (objData.statusReferencial) {
              swal("Atención!", objData.msg, "error");
              tablePreguntas.api().ajax.reload();
            } else {
              swal("Atención!", objData.msg, "error");
            }
          }
        };
      }
    }
  );
}
//Abre el modal para agregar preguntas
function openModal() {
  rowTable = "";
  document.querySelector("#id_pregunta").value = "";
  document.querySelector("#txtpregunta").removeAttribute("readonly");
  document
    .querySelector(".modal-header")
    .classList.replace("headerUpdate", "headerRegister");
  document
    .querySelector("#btnActionForm")
    .classList.replace("btn-info", "btn-primary");
  document.querySelector("#btnText").innerHTML = "Guardar";
  document.querySelector("#titleModal").innerHTML = "Nueva Pregunta";
  document.querySelector("#formPreguntas").reset();

  $("#modalFormPreguntas").modal("show");
}
