let tableObjetos;
let rowTable = "";
let divLoading = document.querySelector("#divLoading");
document.addEventListener(
  "DOMContentLoaded",
  function () {
    tableObjetos = $("#tableObjetos").dataTable({
      aProcessing: true,
      aServerSide: true,
      language: {
        url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json",
      },
      ajax: {
        url: " " + base_url + "/Objetos/getObjetos",
        dataSrc: "",
      },

      columns: [
      { data: "objeto" },
      { data: "descripcion" },
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

    if (document.querySelector("#formObjetos")) {
      let formObjetos = document.querySelector("#formObjetos");
      formObjetos.onsubmit = function (e) {
        e.preventDefault();

        let strobjeto = document.querySelector("#txtobjeto").value;
        let strdescripcion = document.querySelector("#txtdescripcion").value;

        if (strobjeto == "" || strdescripcion == "") {
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
        let ajaxUrl = base_url + "/Objetos/setObjeto";
        let formData = new FormData(formObjetos);
        request.open("POST", ajaxUrl, true);
        request.send(formData);
        request.onreadystatechange = function () {
          if (request.readyState == 4 && request.status == 200) {
            let objData = JSON.parse(request.responseText);
            if (objData.status) {
              if (rowTable == "") {
                tableObjetos.api().ajax.reload();
              } else {
                rowTable.cells[0].textContent = strobjeto;
                rowTable.cells[1].textContent = strdescripcion;

                rowTable = "";
              }

              $("#modalFormObjetos").modal("hide");

              formObjetos.reset();
              swal("Objetos", objData.msg, "success");
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
function fntEditObjeto(element, id_objeto) {
  rowTable = element.parentNode.parentNode.parentNode;
  document.querySelector("#titleModal").innerHTML = "Actualizar Objeto";
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
  let ajaxUrl = base_url + "/Objetos/getObjeto/" + id_objeto;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      let objData = JSON.parse(request.responseText);

      if (objData.status) {
        document.querySelector("#id_objeto").value = objData.data.id_objeto;
        document.querySelector("#txtobjeto").value = objData.data.objeto;
        document.querySelector("#txtdescripcion").value = objData.data.descripcion;

        //Si recibe un usuario, quiere decir que está editando,
        //entonces coloca el input de Usuario como solo lectura
        if (id_objeto) {
          document.querySelector("#txtobjeto").setAttribute("readonly", true);
        }

      }

    }

    $("#modalFormObjetos").modal("show");
  };
}

function fntDelObjeto(id_objeto) {
  swal(
    {
      title: "Eliminar Objeto",
      text: "¿Realmente quiere eliminar el Objeto?",
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
        let ajaxUrl = base_url + "/Objetos/delObjeto";
        let strData = "id_objeto=" + id_objeto;
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
              tableObjetos.api().ajax.reload();
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
  document.querySelector("#id_objeto").value = "";
  document.querySelector("#txtobjeto").removeAttribute("readonly"); //Para quitar el readonly en caso de que antes se haya editado
  document.querySelector(".modal-header").classList.replace("headerUpdate", "headerRegister");
  document.querySelector("#btnActionForm").classList.replace("btn-info", "btn-primary");
  document.querySelector("#btnText").innerHTML = "Guardar";
  document.querySelector("#titleModal").innerHTML = "Nuevo Objeto";
  document.querySelector("#formObjetos").reset();

  $("#modalFormObjetos").modal("show");
}