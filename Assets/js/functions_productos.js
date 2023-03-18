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
        {
          data: "foto",
          render: function (data, type, row) {
            return '<img src="' + data + '"/>';
          },
        },
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

        let strNombre_Producto = document.querySelector(
          "#txtNombre_Producto"
        ).value;
        let strDescripcion = document
          .querySelector("#txtdescripcion")
          .value.toUpperCase();
        let intCantidad_Minima = document.querySelector(
          "#txtCantidad_Minima"
        ).value;
        let intCantidad_Maxima = document.querySelector(
          "#txtCantidad_Maxima"
        ).value;
        let intTipo_Producto =
          document.querySelector("#listTipo_Producto").value;
        let decPrecio_Venta = document.querySelector("#txtPrecio_Venta").value;
        let intStatus = document.querySelector("#listStatus").value;
        let foto = document.querySelector("#foto").value;

        if (
          strNombre_Producto == "" ||
          strDescripcion == "" ||
          intCantidad_Minima == "" ||
          intCantidad_Maxima == "" ||
          intTipo_Producto == "" ||
          decPrecio_Venta == "" ||
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

                rowTable.cells[0].textContent = strNombre_Producto;
                rowTable.cells[1].textContent = strDescripcion;
                rowTable.cells[2].textContent = intCantidad_Minima;
                rowTable.cells[3].textContent = intCantidad_Maxima;

                rowTable.cells[4].textContent =
                  document.querySelector(
                    "#listTipo_Producto"
                  ).selectedOptions[0].text;

                rowTable.cells[5].textContent = decPrecio_Venta;

                rowTable.cells[6].textContent =
                  document.querySelector("#listStatus").selectedOptions[0].text;

                rowTable.cells[7].textContent = foto;

                rowTable.cells[8].innerHTML = htmlStatus;
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

// window.addEventListener(
//   "load",
//   function () {
//     fntRolesUsuario();
//   },
//   false
// );

function fntViewProducto(id_producto) {
  let request = window.XMLHttpRequest
    ? new XMLHttpRequest()
    : new ActiveXObject("Microsoft.XMLHTTP");
  let ajaxUrl = base_url + "/Productos/getProducto/" + id_usuario;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      let objData = JSON.parse(request.responseText);

      if (objData.status) {
        let estadoProducto =
          objData.data.estado == 1
            ? '<span class="badge badge-success">ACTIVO</span>'
            : objData.data.estado == 3
            ? '<span class="badge badge-info">NUEVO</span>'
            : '<span class="badge badge-danger">INACTIVO</span>';

        document.querySelector("#celusuario").innerHTML = objData.data.usuario;
        document.querySelector("#celNombre").innerHTML =
          objData.data.nombre_usuario;
        document.querySelector("#celpreguntas_contestadas").innerHTML =
          objData.data.preguntas_contestadas;
        document.querySelector("#celEmail").innerHTML =
          objData.data.correo_electronico;
        document.querySelector("#celTipoUsuario").innerHTML =
          objData.data.nombrerol;
        document.querySelector("#celEstado").innerHTML = estadoUsuario;
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

//Función cuando se le da click al botón editar Producto
function fntEditUsuario(element, id_usuario) {
  rowTable = element.parentNode.parentNode.parentNode;
  document.querySelector("#titleModal").innerHTML = "Actualizar Usuario";
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
  let ajaxUrl = base_url + "/Usuarios/getUsuario/" + id_usuario;
  request.open("GET", ajaxUrl, true);
  request.send();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      let objData = JSON.parse(request.responseText);

      if (objData.status) {
        document.querySelector("#id_usuario").value = objData.data.id_usuario;

        document.querySelector("#txtusuario").value = objData.data.usuario;

        //Si recibe un usuario, quiere decir que está editando,
        //entonces coloca el input de Usuario como solo lectura
        if (id_usuario) {
          document.querySelector("#txtusuario").setAttribute("readonly", true);
        }

        document.querySelector("#txtnombre_usuario").value =
          objData.data.nombre_usuario;
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

    $("#modalFormUsuario").modal("show");
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
  document.querySelector("#id_usuario").value = "";
  document.querySelector("#txtusuario").removeAttribute("readonly"); //Para quitar el readonly en caso de que antes se haya editado
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
  document.querySelector("#titleModal").innerHTML = "Nuevo Usuario";
  document.querySelector("#formUsuario").reset();
  //$("#listStatus").prop("disabled", true);
  //$("#listStatus").val("3");

  $("#modalFormUsuario").modal("show");
}

function openModalPerfil() {
  $("#modalFormPerfil").modal("show");
}
