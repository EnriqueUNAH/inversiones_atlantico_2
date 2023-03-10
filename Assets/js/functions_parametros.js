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
      columns: [{ data: "parametro" }, { data: "valor" }, { data: "options" }],
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
          swal("Atenci??n", "Todos los campos son obligatorios.", "error");
          return false;
        }

        let elementsValid = document.getElementsByClassName("valid");
        for (let i = 0; i < elementsValid.length; i++) {
          if (elementsValid[i].classList.contains("is-invalid")) {
            swal(
              "Atenci??n",
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
                rowTable.cells[0].textContent = strparametro;
                rowTable.cells[1].textContent = strvalor;

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
  },
  false
);

function fntViewParametro(id_parametro) {
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
        document.querySelector("#elParametro").innerHTML =
          objData.data.parametro;
        document.querySelector("#elValor").innerHTML = objData.data.valor;
        document.querySelector("#elCreadoPor").innerHTML =
          objData.data.creado_por;
        document.querySelector("#elFechaCreacion").innerHTML =
          objData.data.fecha_creacion;
        document.querySelector("#elModificadoPor").innerHTML =
          objData.data.modificado_por;
        document.querySelector("#elFechaModificacion").innerHTML =
          objData.data.fecha_modificacion;

        $("#modalViewParametro").modal("show");
      } else {
        swal("Error", objData.msg, "error");
      }
    }
  };
}

//Funci??n cuando se le da click al bot??n editar Par??metro
function fntEditParametro(element, id_parametro) {
  rowTable = element.parentNode.parentNode.parentNode;
  document.querySelector("#titleModal").innerHTML = "Actualizar Par??metro";
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
      }
    }

    $("#modalFormParametros").modal("show");
  };
}

function fntDelParametro(id_parametro) {
  swal(
    {
      title: "Eliminar Par??metro",
      text: "??Realmente quiere eliminar el Par??metro?",
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
              swal("Atenci??n!", objData.msg, "error");
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
  document
    .querySelector(".modal-header")
    .classList.replace("headerUpdate", "headerRegister");
  document
    .querySelector("#btnActionForm")
    .classList.replace("btn-info", "btn-primary");
  document.querySelector("#btnText").innerHTML = "Guardar";
  document.querySelector("#titleModal").innerHTML = "Nuevo Par??metro";
  document.querySelector("#formParametros").reset();

  $("#modalFormParametros").modal("show");
}
