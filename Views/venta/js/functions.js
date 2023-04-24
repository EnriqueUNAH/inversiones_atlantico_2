$(document).ready(function () {
  $(".btnMenu").click(function (e) {
    e.preventDefault();
    if ($("nav").hasClass("viewMenu")) {
      $("nav").removeClass("viewMenu");
    } else {
      $("nav").addClass("viewMenu");
    }
  });

  $("nav ul li").click(function () {
    $("nav ul li ul").slideUp();
    $(this).children("ul").slideToggle();
  });

  //--------------------- SELECCIONAR FOTO PRODUCTO ---------------------
  $("#foto").on("change", function () {
    var uploadFoto = document.getElementById("foto").value;
    var foto = document.getElementById("foto").files;
    var nav = window.URL || window.webkitURL;
    var contactAlert = document.getElementById("form_alert");

    if (uploadFoto != "") {
      var type = foto[0].type;
      var name = foto[0].name;
      if (type != "image/jpeg" && type != "image/jpg" && type != "image/png") {
        contactAlert.innerHTML =
          '<p class="errorArchivo">El archivo no es válido.</p>';
        $("#img").remove();
        $(".delPhoto").addClass("notBlock");
        $("#foto").val("");
        return false;
      } else {
        contactAlert.innerHTML = "";
        $("#img").remove();
        $(".delPhoto").removeClass("notBlock");
        var objeto_url = nav.createObjectURL(this.files[0]);
        $(".prevPhoto").append("<img id='img' src=" + objeto_url + ">");
        $(".upimg label").remove();
      }
    } else {
      alert("No selecciono foto");
      $("#img").remove();
    }
  });

  $(".delPhoto").click(function () {
    $("#foto").val("");
    $(".delPhoto").addClass("notBlock");
    $("#img").remove();

    if ($("#foto_actual") && $("#foto_remove")) {
      $("#foto_remove").val("img_producto.png");
    }
  });

  // Modal Form Add Product
  $(".add_product").click(function (e) {
    /* Act on the event */
    e.preventDefault();
    var producto = $(this).attr("product");
    var action = "infoProducto";

    $.ajax({
      url: "ajax.php",
      type: "POST",
      async: true,
      data: { action: action, producto: producto },

      success: function (response) {
        if (response != "error") {
          var info = JSON.parse(response);

          //$('#producto_id').val(info.cod_producto);
          //$('.nameProducto').html(info.nombre_producto);

          $(".bodyModal").html(
            '<form action="" method="post" name="form_add_product" id="form_add_product" onsubmit="event.preventDefault(); sendDataProduct();">' +
              '<h1><i class="fas fa-cubes" style="font-size: 45pt;"></i> <br> Agregar Producto</h1>' +
              '<h2 class="nameProducto">' +
              info.nombre_producto +
              "</h2><br>" +
              '<input type="number" name="cantidad" id="txtCantidad" placeholder="Cantidad del producto" required><br>' +
              '<input type="text" name="precio" id="txtPrecio" placeholder="Precio del producto" required>' +
              '<input type="hidden" name="producto_id" id="producto_id" value="' +
              info.cod_producto +
              '" required>' +
              '<input type="hidden" name="action" value="addProduct" required>' +
              '<div class="alert alertAddProduct"></div>' +
              '<button type="submit" class="btn_new"><i class="fas fa-plus"></i> Agregar</button>' +
              '<a href="#" class="btn_ok closeModal" onclick="coloseModal();"><i class="fas fa-ban"></i> Cerrar</a>' +
              "</form>"
          );
        }
      },

      error: function (error) {
        console.log(error);
      },
    });

    $(".modal").fadeIn();
  });

  // Modal Form Delete Product
  $(".del_product").click(function (e) {
    /* Act on the event */
    e.preventDefault();
    var producto = $(this).attr("product");
    var action = "infoProducto";

    $.ajax({
      url: "ajax.php",
      type: "POST",
      async: true,
      data: { action: action, producto: producto },

      success: function (response) {
        if (response != "error") {
          var info = JSON.parse(response);

          //$('#producto_id').val(info.cod_producto);
          //$('.nameProducto').html(info.nombre_producto);

          $(".bodyModal").html(
            '<form action="" method="post" name="form_del_product" id="form_del_product" onsubmit="event.preventDefault(); delProduct();">' +
              '<h1><i class="fas fa-cubes" style="font-size: 45pt;"></i> <br> Eliminar Producto</h1>' +
              "<p>¿Está seguro de eliminar el siguiente registro?</p>" +
              '<h2 class="nameProducto">' +
              info.nombre_producto +
              "</h2><br>" +
              '<input type="hidden" name="producto_id" id="producto_id" value="' +
              info.cod_producto +
              '" required>' +
              '<input type="hidden" name="action" value="delProduct" required>' +
              '<div class="alert alertAddProduct"></div>' +
              '<a href="#" class="btn_cancel" onclick="coloseModal();"><i class="fas fa-ban"></i> Cerrar</a>' +
              '<button type="submit" class="btn_ok"><i class="far fa-trash-alt"></i> Eliminar</button>' +
              "</form>"
          );
        }
      },

      error: function (error) {
        console.log(error);
      },
    });

    $(".modal").fadeIn();
  });

  $("#search_proveedor").change(function (e) {
    e.preventDefault();
    var sistema = getUrl();
    location.href = sistema + "buscar_productos.php?proveedor=" + $(this).val();
  });

  //Activa campos para registrar cliente
  $(".btn_new_cliente").click(function (e) {
    e.preventDefault();
    $("#nom_cliente").removeAttr("disabled");
    $("#tel_cliente").removeAttr("disabled");
    $("#dir_cliente").removeAttr("disabled");

    $("#div_registro_cliente").slideDown();
  });

  //Buscar Cliente
  $("#rtn_cliente").keyup(function (e) {
    e.preventDefault();

    var cl = $(this).val();
    var action = "searchCliente";

    $.ajax({
      url: "ajax.php",
      type: "POST",
      async: true,
      data: { action: action, cliente: cl },

      success: function (response) {
        if (response == 0) {
          $("#cod_cliente").val("");
          $("#nom_cliente").val("");
          $("#tel_cliente").val("");
          $("#dir_cliente").val("");
          //Mostrar boton agregar
          $(".btn_new_cliente").slideDown();
        } else {
          var data = $.parseJSON(response);
          $("#cod_cliente").val(data.cod_cliente);
          $("#nom_cliente").val(data.nombres);
          $("#tel_cliente").val(data.telefono);
          $("#dir_cliente").val(data.direccion);
          //Ocultar boton agregar
          $(".btn_new_cliente").slideUp();

          //Bloque campos
          $("#nom_cliente").attr("disabled", "disabled");
          $("#tel_cliente").attr("disabled", "disabled");
          $("#dir_cliente").attr("disabled", "disabled");

          //Oculta boton guardar
          $("#div_registro_cliente").slideUp();
        }
      },
      error: function (error) {},
    });
  });

  // Crear Cliente - Ventas
  $("#form_new_cliente_venta").submit(function (e) {
    e.preventDefault();

    var nombreCliente = $("#nom_cliente").val();

    // Verificar si el campo del nombre del cliente está vacío
    if (nombreCliente.trim() == "") {
      Swal.fire({
        title: "Por favor ingrese un nombre",
        icon: "error",
        confirmButtonText: "Aceptar",
      });
      return false;
    }

    // Verificar si el nombre del cliente ya existe en la base de datos
    $.ajax({
      url: "ajax.php",
      type: "POST",
      async: true,
      data: {
        action: "validate_nombre_cliente",
        nom_cliente: nombreCliente,
      },

      success: function (response) {
        if (response == "error") {
          Swal.fire({
            title: "El nombre del cliente ya existe",
            icon: "error",
            confirmButtonText: "Aceptar",
          });
        } else {
          //Agregar id a input hiden
          $("#cod_cliente").val(response);
          //Bloque campos
          $("#nom_cliente").attr("disabled", "disabled");
          $("#tel_cliente").attr("disabled", "disabled");
          $("#dir_cliente").attr("disabled", "disabled");

          //Oculta boton agregar
          $(".btn_new_cliente").slideUp();
          //Oculta boton guardar
          $("#div_registro_cliente").slideUp();

          Swal.fire({
            title: "Datos ingresados correctamente",
            icon: "success",
            confirmButtonText: "Aceptar",
          });
        }
      },

      error: function (error) {
        console.log(error);
      },
    });
  });

  //PARA BUSCAR EL PRODUCTO CUANDO SE HACE EL SELECT
  $("#select_producto").change(function (e) {
    e.preventDefault();

    var producto = $(this).val();
    var action = "infoProducto";

    if (producto != "") {
      $.ajax({
        url: "ajax.php",
        type: "POST",
        async: true,
        data: { action: action, producto: producto },

        success: function (response) {
          if (response != "error") {
            var info = JSON.parse(response);
            $("#txt_cod_producto").val(producto);
            $("#txt_nombre_producto").html(info.nombre_producto);
            $("#txt_existencia").html(info.existencia);
            $("#txt_cant_producto").val("1");
            $("#txt_precio").html(info.precio_venta);
            $("#txt_precio_total").html(info.precio_venta);

            //Activar Cantidad
            $("#txt_cant_producto").removeAttr("disabled");

            //Mostrar botón agregar
            $("#add_product_venta").slideDown();
          } else {
            $("#txt_cod_producto").val("");
            $("#txt_nombre_producto").html("-");
            $("#txt_existencia").html("-");
            $("#txt_cant_producto").val("0");
            $("#txt_precio").html("0.00");
            $("#txt_precio_total").html("0.00");

            //Bloquear Cantidad
            $("#txt_cant_producto").attr("disabled", "disabled");

            //Ocultar boton agregar
            $("#add_product_venta").slideUp();
          }
        },
        error: function (error) {},
      });
    }
  });

  $("#select_promocion").change(function (e) {
    e.preventDefault();

    var promocion = $(this).val();
    var action = "infoPromocion";

    if (promocion != "") {
      $.ajax({
        url: "ajax.php",
        type: "POST",
        async: true,
        data: { action: action, promocion: promocion },

        success: function (response) {
          if (response != "error") {
            var info = JSON.parse(response);
            $("#txt_cod_promocion").val(promocion);
            $("#txt_nombre_promocion").html(info.nombre_promocion);
            // $("#txt_existencia").html(info.existencia);
            // $("#txt_cant_producto").val("1");
            // $("#txt_precio").html(info.precio_venta);
            // $("#txt_precio_total").html(info.precio_venta);

            // //Activar Cantidad
            // $("#txt_cant_producto").removeAttr("disabled");

            // //Mostrar botón agregar
            $("#add_promocion_venta").slideDown();
          } else {
            $("#txt_cod_producto").val("");
            $("#txt_nombre_producto").html("-");
            $("#txt_existencia").html("-");
            $("#txt_cant_producto").val("0");
            $("#txt_precio").html("0.00");
            $("#txt_precio_total").html("0.00");

            //Bloquear Cantidad
            $("#txt_cant_producto").attr("disabled", "disabled");

            //Ocultar boton agregar
            $("#add_product_venta").slideUp();
          }
        },
        error: function (error) {},
      });
    }
  });
  $("#select_descuento").change(function (e) {
    e.preventDefault();

    var descuento = $(this).val();
    var action = "infoDescuento";

    if (descuento != "") {
      $.ajax({
        url: "ajax.php",
        type: "POST",
        async: true,
        data: { action: action, descuento: descuento },

        success: function (response) {
          if (response != "error") {
            var info = JSON.parse(response);
            $("#txt_cod_descuento").val(descuento);
            $("#txt_nombre_descuento").html(info.nombre_descuento);
            // $("#txt_existencia").html(info.existencia);
            // $("#txt_cant_producto").val("1");
            // $("#txt_precio").html(info.precio_venta);
            // $("#txt_precio_total").html(info.precio_venta);

            // //Activar Cantidad
            // $("#txt_cant_producto").removeAttr("disabled");

            // //Mostrar botón agregar
            $("#add_descuento_venta").slideDown();
          } else {
            $("#txt_cod_producto").val("");
            $("#txt_nombre_producto").html("-");
            $("#txt_existencia").html("-");
            $("#txt_cant_producto").val("0");
            $("#txt_precio").html("0.00");
            $("#txt_precio_total").html("0.00");

            //Bloquear Cantidad
            $("#txt_cant_producto").attr("disabled", "disabled");

            //Ocultar boton agregar
            $("#add_product_venta").slideUp();
          }
        },
        error: function (error) {},
      });
    }
  });

  // Validar Cantidad del producto antes de agregar
  $("#txt_cant_producto").keyup(function (e) {
    e.preventDefault();

    var precio_total = $(this).val() * $("#txt_precio").html();
    var existencia = parseInt($("#txt_existencia").html());
    $("#txt_precio_total").html(precio_total);

    //Oculta el boton agregar si la cantidad es menor que 1
    if (
      $(this).val() < 1 ||
      isNaN($(this).val()) ||
      $(this).val() > existencia
    ) {
      $("#add_product_venta").slideUp();
    } else {
      $("#add_product_venta").slideDown();
    }
  });

  //Agregar producto al detalle
  $("#add_product_venta").click(function (e) {
    e.preventDefault();

    if ($("#txt_cant_producto").val() > 0) {
      var cod_producto = $("#txt_cod_producto").val();
      var cantidad = $("#txt_cant_producto").val();
      var action = "addProductoDetalle";

      $.ajax({
        url: "ajax.php",
        type: "POST",
        async: true,
        data: { action: action, producto: cod_producto, cantidad: cantidad },

        success: function (response) {
          if (response != "error") {
            var info = JSON.parse(response);
            $("#detalle_venta").html(info.detalle);
            $("#detalle_totales").html(info.totales);

            $("#txt_cod_producto").val("");
            $("#txt_nombre_producto").html("-");
            $("#txt_existencia").html("-");
            $("#txt_cant_producto").val("0");
            $("#txt_precio").html("0.00");
            $("#txt_precio_total").html("0.00");

            //Bloquear Cantidad
            $("#txt_cant_producto").attr("disabled", "disabled");

            //Ocultar boton agregar
            $("#add_product_venta").slideUp();

            /* Lo coloqué para que me recargara la página 
               y así un producto solo lo pueda elegir una vez
              Así ya queda validado para que no se pase de la exitencia
              cuando elige mas de una vez el producto.
            */
            window.location.reload(true);
          } else {
            console.log("no data");
          }
          viewProcesar();
        },
        error: function (error) {},
      });
    }
  });

  //////////////////////////////////////////////////////////
  //Agregar promocion al detalle
  $("#add_promocion_venta").click(function (e) {
    e.preventDefault();

    // if ($("#txt_cant_producto").val() > 0) {
    var cod_promocion = $("#txt_cod_promocion").val();
    // var cantidad = $("#txt_cant_producto").val();
    var action = "addPromocionDetalle";

    $.ajax({
      url: "ajax.php",
      type: "POST",
      async: true,
      data: { action: action, promocion: cod_promocion },

      success: function (response) {
        if (response != "error") {
          console.log(response);
          console.log(info);
          var info = JSON.parse(response);
          $("#detalle_venta").html(info.detalle);
          $("#detalle_totales").html(info.totales);

          $("#txt_cod_producto").val("");
          $("#txt_nombre_producto").html("-");
          $("#txt_existencia").html("-");
          $("#txt_cant_producto").val("0");
          $("#txt_precio").html("0.00");
          $("#txt_precio_total").html("0.00");

          //Bloquear Cantidad
          $("#txt_cant_producto").attr("disabled", "disabled");

          //Ocultar boton agregar
          $("#add_product_venta").slideUp();

          /* Lo coloqué para que me recargara la página 
             y así un producto solo lo pueda elegir una vez
            Así ya queda validado para que no se pase de la exitencia
            cuando elige mas de una vez el producto.
          */
          window.location.reload(true);
        } else {
          console.log("no data");
        }
        viewProcesar();
      },
      error: function (error) {},
    });
    // }
  });

  ////////////////////////////////////////////////////
  //Agregar descuento al detalle
  $("#add_descuento").click(function (e) {
    e.preventDefault();

    // if ($("#txt_cant_producto").val() > 0) {
    var descuento = $("#txt_cod_descuento").val();
    // var cantidad = $("#txt_cant_producto").val();
    var action = "addDescuentoDetalle";

    $.ajax({
      url: "ajax.php",
      type: "POST",
      async: true,
      data: { action: action, descuento: descuento },

      success: function (response) {
        if (response != "error") {
          window.location.reload(true);
          console.log(response);
          console.log(info);
          var info = JSON.parse(response);
          // $("#detalle_venta").html(info.detalle);
          // $("#detalle_totales").html(info.totales);

          // $("#txt_cod_producto").val("");
          // $("#txt_nombre_producto").html("-");
          // $("#txt_existencia").html("-");
          // $("#txt_cant_producto").val("0");
          // $("#txt_precio").html("0.00");
          // $("#txt_precio_total").html("0.00");

          // //Bloquear Cantidad
          // $("#txt_cant_producto").attr("disabled", "disabled");

          // //Ocultar boton agregar
          // $("#add_product_venta").slideUp();

          /* Lo coloqué para que me recargara la página 
             y así un producto solo lo pueda elegir una vez
            Así ya queda validado para que no se pase de la exitencia
            cuando elige mas de una vez el producto.
          */
          window.location.reload(true);
        } else {
          console.log("no data");
        }
        viewProcesar();
      },
      error: function (error) {},
    });
    // }
  });
  //Agregar descuento al detalle
  // $("#addDescuentoDetalle").click(function (e) {
  //   e.preventDefault();

  //   var porcentaje_descuento = $("#txt_porcentaje_descuento").val(); // Modificación aquí
  //   var action = "addDescuentoDetalle";

  //   $.ajax({
  //     url: "ajax.php",
  //     type: "POST",
  //     async: true,
  //     data: { action: action, porcentaje_descuento: porcentaje_descuento }, // Utilizando la variable actualizada

  //     success: function (response) {
  //       if (response != "error") {
  //         try {
  //           var info = JSON.parse(response);
  //           // your code here
  //         } catch (e) {
  //           console.log("Error parsing JSON: " + e);
  //         }

  //         window.location.reload(true);
  //       } else {
  //         console.log("no data");
  //       }
  //       // viewProcesar();
  //     },
  //     error: function (error) {},
  //   });
  // });

  //Anular Venta
  $("#btn_anular_venta").click(function (e) {
    e.preventDefault();

    var rows = $("#detalle_venta tr").length;
    if (rows > 0) {
      var action = "anularVenta";

      $.ajax({
        url: "ajax.php",
        type: "POST",
        async: true,
        data: { action: action },

        success: function (response) {
          if (response != "error") {
            location.reload();
          }
        },
        error: function (error) {},
      });
    }
  });

  //Facturar Venta
  $("#btn_facturar_venta").click(function (e) {
    e.preventDefault();

    var rows = $("#detalle_venta tr").length;
    if (rows > 0) {
      var action = "procesarVenta";
      var cod_cliente = $("#cod_cliente").val();

      $.ajax({
        url: "ajax.php",
        type: "POST",
        async: true,
        data: { action: action, cod_cliente: cod_cliente },

        success: function (response) {
          if (response != "error") {
            var info = JSON.parse(response);
            //console.log(info);
            Swal.fire({
              title: "Venta Exitosa",
              icon: "success",
              confirmButtonText: "OK",
            }).then(() => {
              Swal.fire({
                title: "¿Desea mostrar la factura?",
                icon: "info",
                showCancelButton: true,
                confirmButtonText: "OK",
                cancelButtonText: "Cancelar",
              }).then((result) => {
                if (result.isConfirmed) {
                  generarPDF(info.cod_cliente, info.cod_factura);
                  location.reload();
                  window.location.href = "../../ventas";
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                  window.location.href = "../../ventas";
                }
              });
            });
          } else {
            console.log("no data");
          }
        },
        error: function (error) {},
      });
    }
  });

  // Modal Form Anular Factura
  $(".anular_factura").click(function (e) {
    /* Act on the event */
    e.preventDefault();
    var cod_factura = $(this).attr("fac");
    var action = "infoFactura";

    $.ajax({
      url: "ajax.php",
      type: "POST",
      async: true,
      data: { action: action, cod_factura: cod_factura },

      success: function (response) {
        if (response != "error") {
          var info = JSON.parse(response);

          $(".bodyModal").html(
            '<form action="" method="post" name="form_anular_factura" id="form_anular_factura" onsubmit="event.preventDefault(); anularFactura();">' +
              '<h1><i class="fas fa-cubes" style="font-size: 45pt;"></i> <br> Anular Factura</h1><br>' +
              "<p>¿Realmente desea anular la factura?</p>" +
              "<p><strong>No. " +
              info.cod_factura +
              "</strong></p>" +
              "<p><strong>Monto. Q. " +
              info.totalfactura +
              "</strong></p>" +
              "<p><strong>Fecha. " +
              info.fecha +
              "</strong></p>" +
              '<input type="hidden" name="action" value="anularFactura">' +
              '<input type="hidden" name="no_factura" id="no_factura" value="' +
              info.cod_factura +
              '" required>' +
              '<div class="alert alertAddProduct"></div>' +
              '<button type="submit" class="btn_ok"><i class="far fa-trash-alt"></i> Anular</button>' +
              '<a href="#" class="btn_cancel" onclick="coloseModal();"><i class="fas fa-ban"></i> Cerrar</a>' +
              "</form>"
          );
        }
      },

      error: function (error) {
        console.log(error);
      },
    });

    $(".modal").fadeIn();
  });

  //Ver Factura
  $(".view_factura").click(function (e) {
    e.preventDefault();
    var cod_cliente = $(this).attr("cl");
    var cod_factura = $(this).attr("f");
    generarPDF(cod_cliente, cod_factura);
  });
}); //End Ready

function validPass() {
  var passNuevo = $("#txtNewPassUser").val();
  var confirmPassNuevo = $("#txtPassConfirm").val();
  if (passNuevo != confirmPassNuevo) {
    $(".alertChangePass").html(
      '<p style="color:red;">Las contraeñas no son iguales.</p>'
    );
    $(".alertChangePass").slideDown();
    return false;
  }

  if (passNuevo.length < 5) {
    $(".alertChangePass").html(
      '<p style="color:red;">La nueva contraseña debe ser de 5 caracteres como mínimo.</p>'
    );
    $(".alertChangePass").slideDown();
    return false;
  }

  $(".alertChangePass").html("");
  $(".alertChangePass").slideUp();
}

//Anular factura
function anularFactura() {
  var cod_factura = $("#no_factura").val();
  var action = "anularFactura";

  $.ajax({
    url: "ajax.php",
    type: "POST",
    async: true,
    data: { action: action, cod_factura: cod_factura },

    success: function (response) {
      if (response == "error") {
        $(".alertAddProduct").html(
          '<p style="color:red;">Error al anular la factura.</p>'
        );
      } else {
        $("#row_" + cod_factura + " .estado").html(
          '<span class="anulada">Anulada</span>'
        );
        $("#form_anular_factura .btn_ok").remove();
        $("#row_" + cod_factura + " .div_factura").html(
          '<button type="button" class="btn_anular inactive" ><i class="fas fa-ban"></i></button>'
        );
        $(".alertAddProduct").html("<p>Factura anulada.</p>");
      }
    },
    error: function (error) {},
  });
}

function generarPDF(cliente, factura) {
  var ancho = 1000;
  var alto = 800;
  //Calcular posicion x,y para centrar la ventana
  var x = parseInt(window.screen.width / 2 - ancho / 2);
  var y = parseInt(window.screen.height / 2 - alto / 2);

  $url = "factura/generaFactura.php?cl=" + cliente + "&f=" + factura;
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

function del_product_detalle(cod_detalle_factura) {
  var action = "delProductoDetalle";
  var id_detalle = cod_detalle_factura;

  $.ajax({
    url: "ajax.php",
    type: "POST",
    async: true,
    data: { action: action, id_detalle: id_detalle },

    success: function (response) {
      if (response != "error") {
        var info = JSON.parse(response);
        $("#detalle_venta").html(info.detalle);
        $("#detalle_totales").html(info.totales);

        $("#txt_cod_producto").val("");
        $("#txt_nombre_producto").html("-");
        $("#txt_existencia").html("-");
        $("#txt_cant_producto").val("0");
        $("#txt_precio").html("0.00");
        $("#txt_precio_total").html("0.00");

        //Bloquear Cantidad
        $("#txt_cant_producto").attr("disabled", "disabled");

        //Ocultar boton agregar
        $("#add_product_venta").slideUp();

        /* Lo coloqué para que me recargara la página 
               y así un producto solo lo pueda elegir una vez
              Así ya queda validado para que no se pase de la exitencia
              cuando elige mas de una vez el producto.
            */
        window.location.reload(true);
      } else {
        window.location.reload(true); //Aquí también
        $("#detalle_venta").html("");
        $("#detalle_totales").html("");
      }
      viewProcesar();
    },
    error: function (error) {},
  });
}

//Mostrar/Ocultar boton procesar
function viewProcesar() {
  if ($("#detalle_venta tr").length > 0) {
    $("#btn_facturar_venta").show();
  } else {
    $("#btn_facturar_venta").hide();
  }
}

function serchForDetalle(id) {
  var action = "serchForDetalle";
  var user = id;

  $.ajax({
    url: "ajax.php",
    type: "POST",
    async: true,
    data: { action: action, user: user },

    success: function (response) {
      if (response != "error") {
        var info = JSON.parse(response);
        $("#detalle_venta").html(info.detalle);
        $("#detalle_totales").html(info.totales);
      } else {
        console.log("no data");
      }
      viewProcesar();
    },
    error: function (error) {},
  });
}

function getUrl() {
  var loc = window.location;
  var pathName = loc.pathname.substring(0, loc.pathname.lastIndexOf("/") + 1);
  return loc.href.substring(
    0,
    loc.href.length -
      ((loc.pathname + loc.search + loc.hash).length - pathName.length)
  );
}

function sendDataProduct() {
  $(".alertAddProduct").html("");

  $.ajax({
    url: "ajax.php",
    type: "POST",
    async: true,
    data: $("#form_add_product").serialize(),

    success: function (response) {
      if (response == "error") {
        $(".alertAddProduct").html(
          '<p style="color: red;">Error al agregar el producto.</p>'
        );
      } else {
        var info = JSON.parse(response);
        $(".row" + info.producto_id + " .celPrecio").html(info.nuevo_precio);
        $(".row" + info.producto_id + " .celExistencia").html(
          info.nueva_existencia
        );
        $("#txtCantidad").val("");
        $("#txtPrecio").val("");
        $(".alertAddProduct").html("<p>Producto guardado correctamente.</p>");
      }
    },

    error: function (error) {
      console.log(error);
    },
  });
}

// Eliminar Producto
function delProduct() {
  var pr = $("#producto_id").val();
  $(".alertAddProduct").html("");

  $.ajax({
    url: "ajax.php",
    type: "POST",
    async: true,
    data: $("#form_del_product").serialize(),

    success: function (response) {
      console.log(response);

      if (response == "error") {
        $(".alertAddProduct").html(
          '<p style="color: red;">Error al eliminar el producto.</p>'
        );
      } else {
        $(".row" + pr).remove();
        $("#form_del_product .btn_ok").remove();
        $(".alertAddProduct").html("<p>Producto eliminado correctamente.</p>");
      }
    },

    error: function (error) {
      console.log(error);
    },
  });
}

function coloseModal() {
  $(".alertAddProduct").html("");
  $("#txtCantidad").val("");
  $("#txtPrecio").val("");
  $(".modal").fadeOut();
}

document.addEventListener("DOMContentLoaded", () => {
  const selectProducto = document.getElementById("select_producto");
  const cod_producto = document.getElementById("txt_cod_producto");

  selectProducto.addEventListener("change", (event) => {
    const selectedOption = event.target.options[event.target.selectedIndex];
    const selectedCode = selectedOption.value;

    cod_producto.value = selectedCode;
  });
});
//####################################################################################################################
document.addEventListener("DOMContentLoaded", () => {
  const selectProducto = document.getElementById("select_promocion");
  const cod_promocion = document.getElementById("txt_cod_promocion");

  selectProducto.addEventListener("change", (event) => {
    const selectedOption = event.target.options[event.target.selectedIndex];
    const selectedCode = selectedOption.value;

    cod_promocion.value = selectedCode;
  });
});
//####################################################################################################################
document.addEventListener("DOMContentLoaded", () => {
  const selectDescuento = document.getElementById("select_descuento");
  const cod_descuento = document.getElementById("txt_cod_descuento");

  selectDescuento.addEventListener("change", (event) => {
    const selectedOption = event.target.options[event.target.selectedIndex];
    const selectedCode = selectedOption.value;

    cod_descuento.value = selectedCode;
  });
});

// $(document).ready(function () {
//   // Asignar evento de clic al botón "Agregar"
//   $("#add_descuento").click(function (e) {
//     e.preventDefault();

//     var valor_descuento = $("#valor_descuento").val();

//     // Enviar solicitud POST al archivo PHP
//     $.ajax({
//       url: "ajax.php",
//       type: "POST",
//       data: { valor_descuento: valor_descuento },
//       success: function (response) {
//         // Manejar la respuesta del servidor
//         console.log(response);
//         // location.reload(); // Recargar la página
//       },
//       error: function () {
//         // Manejar errores
//         console.log("Error al actualizar descuento");
//       },
//     });
//   });
// });
