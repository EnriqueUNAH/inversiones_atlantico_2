let tableDescuentos;
let rowTable = "";
$(document).on('focusin', function(e) {
    if ($(e.target).closest(".tox-dialog").length) {
        e.stopImmediatePropagation();
    }
});
tableDescuentos = $('#tableDescuentos').dataTable( {
    "aProcessing":true,
    "aServerSide":true,
    "language": {
        "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
    },
    "ajax":{
        "url": " "+base_url+"/Descuentos/getDescuentos",
        "dataSrc":""
    },
    "columns":[
        {"data":"cod_descuento"},
        {"data":"nombre_descuento"},
        {"data":"porcentaje_descuento"},
        {"data":"options"}
    ],
    "columnDefs": [
                    { 'className': "textcenter", "targets": [ 0 ] },
                    { 'className': "textright", "targets": [ 0 ] },
                    { 'className': "textcenter", "targets": [ 0 ] }
                  ],       
    'dom': 'lBfrtip',
    'buttons': [
          {
            "extend": "excelHtml5",
            "text": "<i class='fas fa-file-excel'></i> Excel",
            "titleAttr":"Esportar a Excel",
            "className": "btn btn-success",
            "exportOptions": { 
                "columns": [ 0, 1, 2] 
            }
        },{
            "extend": "pdfHtml5",
            "text": "<i class='fas fa-file-pdf'></i> PDF",
            "titleAttr":"Esportar a PDF",
            "className": "btn btn-danger",
            "exportOptions": { 
                "columns": [ 0, 1, 2] 
            }
        },
    ],
    "resonsieve":"true",
    "bDestroy": true,
    "iDisplayLength": 10,
    "order":[[0,"asc"]]  
});
window.addEventListener('load', function() {
    if(document.querySelector("#formDescuentos")){
        let formDescuentos = document.querySelector("#formDescuentos");
        formDescuentos.onsubmit = function(e) {
            e.preventDefault();
            let intCodigo = document.querySelector('#txtCodigo').value;
            let strNombre = document.querySelector('#txtNombre').value;
            let intPorcentaje = document.querySelector('#txtPorcentaje').value;
            if(strNombre == '' || intCodigo == '' || intPorcentaje == '')
            {
                swal("Atención", "Todos los campos son obligatorios." , "error");
                return false;
            }
            divLoading.style.display = "flex";
            tinyMCE.triggerSave();
            let request = (window.XMLHttpRequest) ? 
                            new XMLHttpRequest() : 
                            new ActiveXObject('Microsoft.XMLHTTP');
            let ajaxUrl = base_url+'/Descuentos/setDescuentos'; 
            let formData = new FormData(formDescuentos);
            request.open("POST",ajaxUrl,true);
            request.send(formData);
            request.onreadystatechange = function(){
                if(request.readyState == 4 && request.status == 200){
                    let objData = JSON.parse(request.responseText);
                    if(objData.status)
                    {
                        swal("", objData.msg ,"success");
                        document.querySelector("#cod_descuento").value = objData.cod_descuento;
                        document.querySelector("#containerGallery").classList.remove("notblock");

                        if(rowTable == ""){
                            tableProductos.api().ajax.reload();
                        }else{
                        //    htmlStatus = intStatus == 1 ? 
                        //     '<span class="badge badge-success">Activo</span>' : 
                        //     '<span class="badge badge-danger">Inactivo</span>';
                            rowTable.cells[0].textContent = intCodigo;
                            rowTable.cells[1].textContent = strNombre;
                            rowTable.cells[2].textContent = intPorcentaje;
                            // rowTable.cells[3].innerHTML =  htmlStatus;
                            rowTable = ""; 
                        }
                    }else{
                        swal("Error", objData.msg , "error");
                    }
                }
                divLoading.style.display = "none";
                return false;
            }
        }
    }
    fntDescuento();
}, false);


function fntViewInfo(cod_descuento){
  let request = (window.XMLHttpRequest) ? 
                  new XMLHttpRequest() : 
                  new ActiveXObject('Microsoft.XMLHTTP');
  let ajaxUrl = base_url+'/Descuentos/getDescuento/'+cod_descuento;
  request.open("GET",ajaxUrl,true);
  request.send();
  request.onreadystatechange = function(){
      if(request.readyState == 4 && request.status == 200){
          let objData = JSON.parse(request.responseText);
          if(objData)
          {
             
              let objProducto = objData.data;
            //   let estadoProducto = objProducto.status == 1 ? 
            //   '<span class="badge badge-success">Activo</span>' : 
            //   '<span class="badge badge-danger">Inactivo</span>';

              document.querySelector("#celCodigo").innerHTML = objProducto.codigo;
              document.querySelector("#celNombre").innerHTML = objProducto.nombre;
              document.querySelector("#celPorcentaje").innerHTML = objProducto.porcentaje;

            //   if(objProducto.images.length > 0){
            //       let objProductos = objProducto.images;
            //       for (let p = 0; p < objProductos.length; p++) {
            //           htmlImage +=`<img src="${objProductos[p].url_image}"></img>`;
            //       }
            //   }
            
              $('#modalViewDescuentos').modal('show');

          }else{
              swal("Error", objData.msg , "error");
          }
      }
  } 
}

function fntEditInfo(element,cod_descuento){
    rowTable = element.parentNode.parentNode.parentNode;
    document.querySelector('#titleModal').innerHTML ="Editar Descuento";
    document.querySelector('.modal-header').classList.replace("headerRegister", "headerUpdate");
    document.querySelector('#btnActionForm').classList.replace("btn-primary", "btn-info");
    document.querySelector('#btnText').innerHTML ="Actualizar";
    let request = (window.XMLHttpRequest) ? 
                    new XMLHttpRequest() : 
                    new ActiveXObject('Microsoft.XMLHTTP');
    let ajaxUrl = base_url+'/Descuentos/getDescuento/'+cod_descuento;
    request.open("GET",ajaxUrl,true);
    request.send();
    request.onreadystatechange = function(){
        if(request.readyState == 4 && request.status == 200){
            let objData = JSON.parse(request.responseText);
            if(objData.status)
            {
                let htmlImage = "";
                let objProducto = objData.data;
                // document.querySelector("#idProducto").value = objProducto.idproducto;
                document.querySelector("#txtNombre").value = objProducto.nombre;
                // document.querySelector("#txtDescripcion").value = objProducto.descripcion;
                document.querySelector("#txtCodigo").value = objProducto.codigo;
                document.querySelector("#txtPorcentaje").value = objProducto.porcentaje;
                // document.querySelector("#txtStock").value = objProducto.stock;
                // document.querySelector("#listCategoria").value = objProducto.categoriaid;
                document.querySelector("#listDescuento").value = objProducto.status;
                tinymce.activeEditor.setContent(objProducto.nombre); 
                $('#listDescuento').selectpicker('render');
                // $('#listStatus').selectpicker('render');
                // fntBarcode();

                // if(objProducto.images.length > 0){
                //     let objProductos = objProducto.images;
                //     for (let p = 0; p < objProductos.length; p++) {
                //         let key = Date.now()+p;
                //         htmlImage +=`<div id="div${key}">
                //             <div class="prevImage">
                //             <img src="${objProductos[p].url_image}"></img>
                //             </div>
                //             <button type="button" class="btnDeleteImage" onclick="fntDelItem('#div${key}')" imgname="${objProductos[p].img}">
                //             <i class="fas fa-trash-alt"></i></button></div>`;
                //     }
                // }
                // document.querySelector("#containerImages").innerHTML = htmlImage; 
                // document.querySelector("#divBarCode").classList.remove("notblock");
                // document.querySelector("#containerGallery").classList.remove("notblock");           
                $('#modalFormDescuentos').modal('show');
            }else{
                swal("Error", objData.msg , "error");
            }
        }
    }
}


function fntDelInfo(cod_descuento){
  swal({
      title: "Eliminar Descuento",
      text: "¿Realmente quiere eliminar el descuento?",
      type: "warning",
      showCancelButton: true,
      confirmButtonText: "Si, eliminar!",
      cancelButtonText: "No, cancelar!",
      closeOnConfirm: false,
      closeOnCancel: true
  }, function(isConfirm) {
      
      if (isConfirm) 
      {
          let request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
          let ajaxUrl = base_url+'/Descuentos/delDescuento';
          let strData = "cod_descuento="+cod_descuento;
          request.open("POST",ajaxUrl,true);
          request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
          request.send(strData);
          request.onreadystatechange = function(){
              if(request.readyState == 4 && request.status == 200){
                  let objData = JSON.parse(request.responseText);
                  if(objData.status)
                  {
                    swal("Atención!", objData.msg , "error");
                  }else{
                      swal("Eliminar!", objData.msg , "success");
                      tableDescuentos.api().ajax.reload();
                  }
              }
          }
      }

  });

}

function fntDescuento(){
  if(document.querySelector('#listDescuento')){
      let ajaxUrl = base_url+'/Descuentos/getDescuentos';
      let request = (window.XMLHttpRequest) ? 
                  new XMLHttpRequest() : 
                  new ActiveXObject('Microsoft.XMLHTTP');
      request.open("GET",ajaxUrl,true);
      request.send();
      request.onreadystatechange = function(){
          if(request.readyState == 4 && request.status == 200){
              document.querySelector('#listDescuento').innerHTML = request.responseText;
              $('#listDescuento').selectpicker('render');
          }
      }
  }
}

function openModal()
{
    rowTable = "";
    document.querySelector('#cod_descuento').value ="";
    document.querySelector('.modal-header').classList.replace("headerUpdate", "headerRegister");
    document.querySelector('#btnActionForm').classList.replace("btn-info", "btn-primary");
    document.querySelector('#btnText').innerHTML ="Guardar";
    document.querySelector('#titleModal').innerHTML = "Nuevo Descuento";
    document.querySelector("#formDescuentos").reset();
    $('#modalFormDescuentos').modal('show');

}