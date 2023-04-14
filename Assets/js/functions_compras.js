let tableCompras;
let rowTable = "";
let divLoading = document.querySelector("#divLoading");
document.addEventListener(
  "DOMContentLoaded",
  function () {
    tableCompras = $("#tableCompras").dataTable({
      aProcessing: true,
      aServerSide: true,
      language: {
        url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json",
      },
      ajax: {
        url: " " + base_url + "/Compras/getCompras",
        dataSrc: "",
      },
      columns: [
        { data: "cod_compra" },
        { data: "total_pagado",
          render: function (data, type, row) {
            return "L. " + data;
          },
        },

        { data: "fecha" },
        { data: "usuario" },
        { data: "estado" },
        { data: "options" }
      ],
      dom: "lBfrtip",
      buttons: [
        {
          extend: "pdfHtml5",
          text: "<i class='fas fa-file-pdf'></i> PDF",
          titleAttr: "Exportar a PDF",
          className: "btn btn-danger",
          exportOptions: {
            columns: [0, 1, 2, 3, 4],
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

  },
  false
);




function fntDelCompra(cod_compra) {
  swal(
    {
      title: "Anular Compra",
      text: "¿Realmente quiere anular la compra?",
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
        let ajaxUrl = base_url + "/Compras/delCompra";
        let strData = "cod_compra=" + cod_compra;
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
              tableCompras.api().ajax.reload();
            } else if (objData.statusReferencial) {
              swal("Atención!", objData.msg, "error");
              tableCompras.api().ajax.reload();
            } else {
              swal("Atención!", objData.msg, "error");
            }
          }
        };
      }
    }
  );
}

//Abre el modal para agregar usuario
function openModal() {
  rowTable = "";
  document.querySelector("#cod_compra").value = "";
  //document.querySelector("#txtusuario").removeAttribute("readonly"); //Para quitar el readonly en caso de que antes se haya editado
  //document.querySelector("#listStatus").setAttribute("readonly", true);
  // document.querySelector("#listStatus").setAttribute("disabled", true);
  // if (rowTable) {
  //   document.querySelector("#listStatus").removeAttribute("disabled");
  // } else {
  //   // Si se está agregando un nuevo registro
  //   document.querySelector("#listStatus").value = "3";
  //   document.querySelector("#listStatus").setAttribute("disabled", true);
  // }
  document.querySelector(".modal-header").classList.replace("headerUpdate", "headerRegister");
  document.querySelector("#btnActionForm").classList.replace("btn-info", "btn-primary");
  document.querySelector("#btnText").innerHTML = "Guardar";
  document.querySelector("#titleModal").innerHTML = "Nueva compra";
  document.querySelector("#formCompra").reset();
  //$("#listStatus").prop("disabled", true);
  //$("#listStatus").val("3");

  $("#modalFormCompra").modal("show");
}

function openModalPerfil() {
  $("#modalFormPerfil").modal("show");
}

function ver_compra(codCompra) {
  var cod_compra = codCompra;
  generarPDF(cod_compra);
}

function generarPDF(compra) {
  var ancho = 1000;
  var alto = 800;
  //Calcular posicion x,y para centrar la ventana
  var x = parseInt(window.screen.width / 2 - ancho / 2);
  var y = parseInt(window.screen.height / 2 - alto / 2);

  $url =
    "Views/compra/factura/generaFactura.php?f=" +compra;
  window.open(
    $url,
    "Compra",
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