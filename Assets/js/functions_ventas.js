let tableVentas;
let rowTable = "";
let divLoading = document.querySelector("#divLoading");
document.addEventListener(
  "DOMContentLoaded",
  function () {
    tableVentas = $("#tableVentas").dataTable({
      aProcessing: true,
      aServerSide: true,
      language: {
        url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json",
      },
      ajax: {
        url: " " + base_url + "/Ventas/getVentas",
        dataSrc: "",
      },
      columns: [
        { data: "numero_factura" },
        { data: "fecha" },
        { data: "usuario" },
        { data: "cod_cliente" },
        { data: "subtotal" },
        { data: "isv" },
        { data: "porcentaje_isv" },
        { data: "totalfactura" },
        { data: "estado" },
      ],
      dom: "lBfrtip",
      buttons: [
        {
          extend: "excelHtml5",
          text: "<i class='fas fa-file-excel'></i> Excel",
          titleAttr: "Exportar a Excel",
          className: "btn btn-success",
          exportOptions: {
            columns: [0, 1, 2, 3, 4, 5, 6, 7],
          },
        },
        {
          extend: "pdfHtml5",
          text: "<i class='fas fa-file-pdf'></i> PDF",
          titleAttr: "Exportar a PDF",
          className: "btn btn-danger",
          exportOptions: {
            columns: [0, 1, 2, 3, 4, 5, 6, 7],
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
    //////

    ///////
  },
  false
);

window.addEventListener(
  "load",
  function () {
    fntRolesVenta();
  },
  false
);

function fntRolesVenta() {
  if (document.querySelector("#listid_rol")) {
    let ajaxUrl = base_url + "/Roles/getSelectRoles";
    let request = window.XMLHttpRequest
      ? new XMLHttpRequest()
      : new ActiveXObject("Microsoft.XMLHTTP");
    request.open("GET", ajaxUrl, true);
    request.send();
    request.onreadystatechange = function () {
      if (request.readyState == 4 && request.status == 200) {
        document.querySelector("#listid_rol").innerHTML = request.responseText;
        $("#listid_rol").selectpicker("render");
      }
    };
  }
}

function fntViewVenta(id_Venta) {
  let request = window.XMLHttpRequest
    ? new XMLHttpRequest()
    : new ActiveXObject("Microsoft.XMLHTTP");
  let ajaxUrl = base_url + "/Ventas/getVenta/" + id_Venta;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      let objData = JSON.parse(request.responseText);

      if (objData.status) {
        let estadoVenta =
          objData.data.estado == 1
            ? '<span class="badge badge-success">ACTIVO</span>'
            : objData.data.estado == 3
            ? '<span class="badge badge-danger">ANULADA</span>'
            : '<span class="badge badge-danger">INACTIVO</span>';

        document.querySelector("#celVenta").innerHTML = objData.data.Venta;
        document.querySelector("#celNombre").innerHTML =
          objData.data.nombre_Venta;
        document.querySelector("#celpreguntas_contestadas").innerHTML =
          objData.data.preguntas_contestadas;
        document.querySelector("#celEmail").innerHTML =
          objData.data.correo_electronico;
        document.querySelector("#celTipoVenta").innerHTML =
          objData.data.nombrerol;
        document.querySelector("#celEstado").innerHTML = estadoVenta;
        document.querySelector("#celFechaUltimaConexion").innerHTML =
          objData.data.fecha_ultima_conexion;
        document.querySelector("#celFechaVencimiento").innerHTML =
          objData.data.fecha_vencimiento;
        document.querySelector("#celPrimerIngreso").innerHTML =
          objData.data.primer_ingreso;
        document.querySelector("#celCreadoPor").innerHTML =
          objData.data.creado_por;
        document.querySelector("#celFechaRegistro").innerHTML =
          objData.data.fechaRegistro;
        document.querySelector("#celModificadoPor").innerHTML =
          objData.data.modificado_por;
        document.querySelector("#celFechaModificacion").innerHTML =
          objData.data.fecha_modificacion;

        $("#modalViewUser").modal("show");
      } else {
        swal("Error", objData.msg, "error");
      }
    }
  };
}

//Función cuando se le da click al botón editar Venta
function fntEditVenta(element, id_Venta) {
  rowTable = element.parentNode.parentNode.parentNode;
  document.querySelector("#titleModal").innerHTML = "Actualizar Venta";
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
  let ajaxUrl = base_url + "/Ventas/getVenta/" + id_Venta;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      let objData = JSON.parse(request.responseText);

      if (objData.status) {
        document.querySelector("#id_Venta").value = objData.data.id_Venta;

        document.querySelector("#txtVenta").value = objData.data.Venta;

        //Si recibe un Venta, quiere decir que está editando,
        //entonces coloca el input de Venta como solo lectura
        if (id_Venta) {
          document.querySelector("#txtVenta").setAttribute("readonly", true);
        }

        document.querySelector("#txtnombre_Venta").value =
          objData.data.nombre_Venta;
        document.querySelector("#txtEmail").value =
          objData.data.correo_electronico;
        document.querySelector("#listid_rol").value = objData.data.id_rol;
        $("#listid_rol").selectpicker("render");

        if (objData.data.estado == 1) {
          document.querySelector("#listStatus").value = 1;
        } else if (objData.data.estado == 2) {
          document.querySelector("#listStatus").value = 2;
        } else {
          document.querySelector("#listStatus").value = 3;
        }

        $("#listStatus").selectpicker("render");
      }
    }

    $("#modalFormVenta").modal("show");
  };
}

function fntDelVenta(id_Venta) {
  swal(
    {
      title: "Eliminar Venta",
      text: "¿Realmente quiere eliminar el Venta?",
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
        let ajaxUrl = base_url + "/Ventas/delVenta";
        let strData = "id_Venta=" + id_Venta;
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
              tableVentas.api().ajax.reload();
            } else if (objData.statusReferencial) {
              swal("Atención!", objData.msg, "error");
              tableVentas.api().ajax.reload();
            } else {
              swal("Atención!", objData.msg, "error");
            }
          }
        };
      }
    }
  );
}

//Abre el modal para agregar Venta
function openModal() {
  rowTable = "";
  document.querySelector("#id_Venta").value = "";
  document.querySelector("#txtVenta").removeAttribute("readonly"); //Para quitar el readonly en caso de que antes se haya editado
  //document.querySelector("#listStatus").setAttribute("readonly", true);
  // document.querySelector("#listStatus").setAttribute("disabled", true);
  // if (rowTable) {
  //   document.querySelector("#listStatus").removeAttribute("disabled");
  // } else {
  //   // Si se está agregando un nuevo registro
  //   document.querySelector("#listStatus").value = "3";
  //   document.querySelector("#listStatus").setAttribute("disabled", true);
  // }
  document
    .querySelector(".modal-header")
    .classList.replace("headerUpdate", "headerRegister");
  document
    .querySelector("#btnActionForm")
    .classList.replace("btn-info", "btn-primary");
  document.querySelector("#btnText").innerHTML = "Guardar";
  document.querySelector("#titleModal").innerHTML = "Nuevo Venta";
  document.querySelector("#formVenta").reset();
  //$("#listStatus").prop("disabled", true);
  //$("#listStatus").val("3");

  $("#modalFormVenta").modal("show");
}

function openModalPerfil() {
  $("#modalFormPerfil").modal("show");
}