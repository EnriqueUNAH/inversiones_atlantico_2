let tableProductos;
let rowTable = "";
let divLoading = document.querySelector("#divLoading");
document.addEventListener(
  "DOMContentLoaded",
  function () {
    tableProductos = $("#tableProductos").dataTable({
      aProcessing: true,
      aServerSide: true,
      language: {
        url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json",
      },
      ajax: {
        url: " " + base_url + "/Productos/getProductos",
        dataSrc: "",
      },
      columns: [
        { data: "nombre_producto" },
        { data: "descripcion" },
        { data: "cantidad_minima" },
        { data: "cantidad_maxima" },
        { data: "nombre_tipo_producto" },
        { data: "precio_venta" },
        { data: "estado" },
        { data: "options" },
        // {
        //   data: "foto",
        //   render: function (data, type, row) {
        //     return '<img src="' + data + '"/>';
        //   },
        // },
      ],
      dom: "lBfrtip",
      buttons: [
        {
          extend: "excelHtml5",
          text: "<i class='fas fa-file-excel'></i> Excel",
          titleAttr: "Exportar a Excel",
          className: "btn btn-success",
          exportOptions: {
            columns: [0, 1, 2, 3, 4, 5],
          },
        },
        {
          extend: "pdfHtml5",
          text: "<i class='fas fa-file-pdf'></i> PDF",
          titleAttr: "Exportar a PDF",
          className: "btn btn-danger",
          exportOptions: {
            columns: [0, 1, 2, 3, 4, 5],
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

    if (document.querySelector("#formProducto")) {
      let formProducto = document.querySelector("#formProducto");
      formProducto.onsubmit = function (e) {
        e.preventDefault();

        let strNombreProducto = document.querySelector("#txtnombre").value.toUpperCase();
        let strDescripcion = document.querySelector("#txtdescripcion").value.toUpperCase();
        let intCantidadMinima = document.querySelector("#intCantidadMin").value;
        let intCantidadMaxima = document.querySelector("#intCantidadMax").value;
        let intCodTipoProducto = document.querySelector("#listTipo").value;
        let decPrecioVenta = document.querySelector("#intprecio").value;
        let intStatus = document.querySelector("#listStatus").value;


        if (
          strNombreProducto == "" ||
          strDescripcion == "" ||
          intCantidadMinima == "" ||
          intCantidadMaxima == "" ||
          intCodTipoProducto == "" ||
          decPrecioVenta == "" ||
          intStatus == ""
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
        let ajaxUrl = base_url + "/Productos/setProducto";
        let formData = new FormData(formProducto);
        request.open("POST", ajaxUrl, true);
        request.send(formData);
        request.onreadystatechange = function () {
          if (request.readyState == 4 && request.status == 200) {
            let objData = JSON.parse(request.responseText);
            if (objData.status) {
              if (rowTable == "") {
                tableProductos.api().ajax.reload();
              } else {
                htmlStatus =
                  intStatus == 1
                    ? '<span class="badge badge-success">ACTIVO</span>'
                    : intStatus == 3
                    ? '<span class="badge badge-info">NUEVO</span>'
                    : intStatus == 4
                    ? '<span class="badge badge-danger">BLOQUEADO</span>'
                    : '<span class="badge badge-danger">INACTIVO</span>';

                rowTable.cells[0].textContent = strNombreProducto;
                rowTable.cells[1].textContent = strDescripcion;
                rowTable.cells[2].textContent = intCantidadMinima;
                rowTable.cells[3].textContent = intCantidadMaxima;
                rowTable.cells[4].textContent = document.querySelector("#listTipo").selectedOptions[0].text;
                rowTable.cells[5].textContent = decPrecioVenta;
                rowTable.cells[6].innerHTML = htmlStatus;
                rowTable = "";
              }

              $("#modalFormProducto").modal("hide");

              formProducto.reset();
              swal("Productos", objData.msg, "success");
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

window.addEventListener(
  "load",
  function () {
    fntTipoProducto();
  },
  false
);

function fntTipoProducto() {
  if (document.querySelector("#listTipo")) {
    let ajaxUrl = base_url + "/Productos/getSelectTipoProducto";
    let request = window.XMLHttpRequest
      ? new XMLHttpRequest()
      : new ActiveXObject("Microsoft.XMLHTTP");
    request.open("GET", ajaxUrl, true);
    request.send();
    request.onreadystatechange = function () {
      if (request.readyState == 4 && request.status == 200) {
        document.querySelector("#listTipo").innerHTML = request.responseText;
        $("#listTipo").selectpicker("render");
      }
    };
  }
}





function fntViewProducto(cod_producto) {
  let request = window.XMLHttpRequest
    ? new XMLHttpRequest()
    : new ActiveXObject("Microsoft.XMLHTTP");
  let ajaxUrl = base_url + "/Productos/getProducto/" + cod_producto;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      let objData = JSON.parse(request.responseText);

      if (objData.status) {
        let estado =
          objData.data.estado == 1
            ? '<span class="badge badge-success">ACTIVO</span>'
            : objData.data.estado == 3
            ? '<span class="badge badge-info">NUEVO</span>'
            : '<span class="badge badge-danger">INACTIVO</span>';

        document.querySelector("#celNombre").innerHTML = objData.data.nombre_producto;
        document.querySelector("#celDescripcion").innerHTML = objData.data.descripcion;
        document.querySelector("#celCantMin").innerHTML = objData.data.cantidad_minima;
        document.querySelector("#celCantMax").innerHTML = objData.data.cantidad_maxima;
        document.querySelector("#celTipoProducto").innerHTML = objData.data.nombre_tipo_producto;
        document.querySelector("#celPrecio").innerHTML = objData.data.precio_venta;
        document.querySelector("#celEstado").innerHTML = estado;
        document.querySelector("#celCreadoPor").innerHTML = objData.data.creado_por;
        document.querySelector("#celFechaCreacion").innerHTML = objData.data.fecha_creacion;
        document.querySelector("#celModificadoPor").innerHTML = objData.data.modificado_por;
        document.querySelector("#celFechaModificacion").innerHTML = objData.data.fecha_modificacion;
        

        $("#modalViewProducto").modal("show");
      } else {
        swal("Error", objData.msg, "error");
      }
    }
  };
}

//Función cuando se le da click al botón editar Producto
function fntEditProducto(element, cod_producto) {
  rowTable = element.parentNode.parentNode.parentNode;
  document.querySelector("#titleModal").innerHTML = "Actualizar Producto";
  document.querySelector(".modal-header").classList.replace("headerRegister", "headerUpdate");
  document.querySelector("#btnActionForm").classList.replace("btn-primary", "btn-info");
  document.querySelector("#btnText").innerHTML = "Actualizar";
  let request = window.XMLHttpRequest
    ? new XMLHttpRequest()
    : new ActiveXObject("Microsoft.XMLHTTP");
  let ajaxUrl = base_url + "/Productos/getProducto/" + cod_producto;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      let objData = JSON.parse(request.responseText);

      if (objData.status) {
        document.querySelector("#cod_producto").value = objData.data.cod_producto;
        document.querySelector("#txtnombre").value = objData.data.nombre_producto;
        document.querySelector("#txtdescripcion").value = objData.data.descripcion;
        document.querySelector("#intCantidadMin").value = objData.data.cantidad_minima;
        document.querySelector("#intCantidadMax").value = objData.data.cantidad_maxima;
        document.querySelector("#listTipo").value = objData.data.cod_tipo_producto;
        $("#listTipo").selectpicker("render");
        document.querySelector("#intprecio").value = objData.data.precio_venta;

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

    $("#modalFormProducto").modal("show");
  };
}

function fntDelUsuario(id_usuario) {
  swal(
    {
      title: "Eliminar Usuario",
      text: "¿Realmente quiere eliminar el Usuario?",
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
        let ajaxUrl = base_url + "/Usuarios/delUsuario";
        let strData = "id_usuario=" + id_usuario;
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
              tableUsuarios.api().ajax.reload();
            } else if (objData.statusReferencial) {
              swal("Atención!", objData.msg, "error");
              tableUsuarios.api().ajax.reload();
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
  document.querySelector("#cod_producto").value = "";
  // document.querySelector("#txtusuario").removeAttribute("readonly"); //Para quitar el readonly en caso de que antes se haya editado
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
  document.querySelector("#titleModal").innerHTML = "Nuevo Producto";
  document.querySelector("#formProducto").reset();
  //$("#listStatus").prop("disabled", true);
  //$("#listStatus").val("3");

  $("#modalFormProducto").modal("show");
}

function openModalPerfil() {
  $("#modalFormPerfil").modal("show");
}
