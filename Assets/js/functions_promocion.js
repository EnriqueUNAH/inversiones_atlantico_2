let tablePromocion;
let rowTable = "";
let divLoading = document.querySelector("#divLoading");
document.addEventListener(
  "DOMContentLoaded",
  function () {
    tablePromocion = $("#tablePromocion").dataTable({
      aProcessing: true,
      aServerSide: true,
      language: {
        url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json",
      },
      ajax: {
        url: " " + base_url + "/Promocion/getPromocion",
        dataSrc: "",
      },
      columns: [
      { data: "nombre_promocion" },
      { data: "fecha_inicio" },
      { data: "fecha_final" },
      { data: "precio_venta" },
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
            columns: [0, 1, 2, 3],
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

    if (document.querySelector("#formPromocion")) {
      letformPromocion = document.querySelector("#formPromocion");
     formPromocion.onsubmit = function (e) {
        e.preventDefault();

        let strnombre_promocion = document.querySelector("#txtnombre_promocion").value.toUpperCase();
        let datefecha_inicio = document.querySelector("#txtfecha_inicio").value;
        let datefecha_final = document.querySelector("#txtfecha_final").value;
        let intprecio_venta = document.querySelector("#txtprecio_venta").value;

        if (strnombre_promocion == "" || datefecha_inicio == "" || datefecha_final == "" || intprecio_venta == "") {
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
        let ajaxUrl = base_url + "/Promocion/setPromocion";
        let formData = new FormData(formPromocion);
        request.open("POST", ajaxUrl, true);
        request.send(formData);
        request.onreadystatechange = function () {
          if (request.readyState == 4 && request.status == 200) {
            let objData = JSON.parse(request.responseText);
            if (objData.status) {
              if (rowTable == "") {
                tablePromocion.api().ajax.reload();
              } else {
             rowTable.cells[0].textContent = strnombre_promocion;
             rowTable.cells[1].textContent = datefecha_inicio;
             rowTable.cells[2].textContent = datefecha_final;
             rowTable.cells[3].textContent = intprecio_venta;

                rowTable = "";
              }

              $("#modalFormPromocion").modal("hide");

             formPromocion.reset();
              swal("Promocion", objData.msg, "success");
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
function fntEditPromocion(element, cod_promocion) {
  rowTable = element.parentNode.parentNode.parentNode;
  document.querySelector("#titleModal").innerHTML = "Actualizar Promocion";
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
  let ajaxUrl = base_url + "/Promocion/getPromocion1/" + cod_promocion;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      let objData = JSON.parse(request.responseText);

      if (objData.status) {
        document.querySelector("#cod_promocion").value =
          objData.data.cod_promocion;

        document.querySelector("#txtnombre_promocion").value = objData.data.nombre_promocion;
        document.querySelector("#txtfecha_inicio").value = objData.data.fecha_inicio;
        document.querySelector("#txtfecha_final").value = objData.data.fecha_final;
        document.querySelector("#txtprecio_venta").value = objData.data.precio_venta;



      }
    }

    $("#modalFormPromocion").modal("show");
  };
}

function fntDelPromocion(cod_promocion) {
  swal(
    {
      title: "Eliminar promocion",
      text: "¿Realmente quiere eliminar la promocion?",
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
        let ajaxUrl = base_url + "/Promocion/delPromocion";
        let strData = "cod_promocion=" + cod_promocion;
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
              tablePromocion.api().ajax.reload();
            } else {
              swal("Atención!", objData.msg, "error");
            }
          }
        };
      }
    }
  );
}

//Abre el modal para agregar promocion
function openModal() {
  rowTable = "";
  document.querySelector("#cod_promocion").value = "";
  document
    .querySelector(".modal-header")
    .classList.replace("headerUpdate", "headerRegister");
  document
    .querySelector("#btnActionForm")
    .classList.replace("btn-info", "btn-primary");
  document.querySelector("#btnText").innerHTML = "Guardar";
  document.querySelector("#titleModal").innerHTML = "Nueva Promocion";
  document.querySelector("#formPromocion").reset();

  $("#modalFormPromocion").modal("show");
}
