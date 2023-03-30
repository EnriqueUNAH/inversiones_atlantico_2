let tableResultado; 
let rowTable = "";
let divLoading = document.querySelector("#divLoading");
document.addEventListener('DOMContentLoaded', function(){

    tableResultado = $('#tableResultado').dataTable( {
        "aProcessing":true,
        "aServerSide":true,
        "language": {
            "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
        },
        "ajax":{
            "url": " "+base_url+"/Resultado/getResultado",
            "dataSrc":""
        },
        "columns":[
            {"data":"cod_producto"},
            {"data":"cantidad"},
            {"data":"descripcion"}
        ],
        'dom': 'lBfrtip',
        'buttons': [
            {
                "extend": "excelHtml5",
                "text": "<i class='fas fa-file-excel'></i> Excel",
                "titleAttr":"Esportar a Excel",
                "className": "btn btn-success"
            },{
                "extend": "pdfHtml5",
                "text": "<i class='fas fa-file-pdf'></i> PDF",
                "titleAttr":"Esportar a PDF",
                "className": "btn btn-danger"
            }
        ],
        "resonsieve":"true",
        "bDestroy": true,
        "iDisplayLength": 10,
        "order":[[0,"desc"]]  
    });

	if(document.querySelector("#formResultado")){
        let formResultado = document.querySelector("#formResultado");
        formResultado.onsubmit = function(e) {
            e.preventDefault();
            let intCodigo = document.querySelector('#txtCodigo').value;
            let intCantidad = document.querySelector('#txtCantidad').value;
            let strDescripcion = document.querySelector('#txtDescripcion').value;

            if(strDescripcion == '' || intCantidad == '')
            {
                swal("Atención", "Todos los campos son obligatorios." , "error");
                return false;
            }

            let elementsValid = document.getElementsByClassName("valid");
            for (let i = 0; i < elementsValid.length; i++) { 
                if(elementsValid[i].classList.contains('is-invalid')) { 
                    swal("Atención", "Por favor verifique los campos en rojo." , "error");
                    return false;
                } 
            } 
            divLoading.style.display = "flex";
            let request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
            let ajaxUrl = base_url+'/Resultado/setResultado'; 
            let formData = new FormData(formResultado);
            request.open("POST",ajaxUrl,true);
            request.send(formData);
            request.onreadystatechange = function(){
                if(request.readyState == 4 && request.status == 200){
                    let objData = JSON.parse(request.responseText);
                    if(objData.status)
                    {
                        if(rowTable == ""){
                            tableResultado.api().ajax.reload();
                        }else{
                           rowTable.cells[0].textContent =  cod_producto;
                           rowTable.cells[1].textContent =  intCantidad;
                           rowTable.cells[2].textContent =  strDescripcion;
                           rowTable = "";
                        }
                        $('#modalFormResultado').modal("hide");
                        formResultado.reset();
                        swal("Resultado", objData.msg ,"success");
                    }else{
                        swal("Error", objData.msg , "error");
                    }
                }
                divLoading.style.display = "none";
                return false;
            }
        }
    }


}, false);


function fntViewInfo(cod_producto){
    let request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
    let ajaxUrl = base_url+'/Resultado/getResultado/'+cod_producto;
    request.open("GET",ajaxUrl,true);
    request.send();
    request.onreadystatechange = function(){
        if(request.readyState == 4 && request.status == 200){
            let objData = JSON.parse(request.responseText);
            if(objData.status)
            {
                document.querySelector("#txtCodigo").innerHTML = objData.data.cod_producto;
                document.querySelector("#txtCantidad").innerHTML = objData.data.intCantidad;
                document.querySelector("#txtDescripcion").innerHTML = objData.data.strDescripcion;
                $('#modalViewResultado').modal('show');
            }else{
                swal("Error", objData.msg , "error");
            }
        }
    }
}

function fntEditInfo(element,cod_producto){
    rowTable = element.parentNode.parentNode.parentNode;
    document.querySelector('#titleModal').innerHTML ="Actualizar Resultado";
    document.querySelector('.modal-header').classList.replace("headerRegister", "headerUpdate");
    document.querySelector('#btnActionForm').classList.replace("btn-primary", "btn-info");
    document.querySelector('#btnText').innerHTML ="Actualizar";
    let request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
    let ajaxUrl = base_url+'/Resultado/getResultado/'+cod_producto;
    request.open("GET",ajaxUrl,true);
    request.send();
    request.onreadystatechange = function(){

        if(request.readyState == 4 && request.status == 200){
            let objData = JSON.parse(request.responseText);
            if(objData.status)
            {
                // document.querySelector("#idUsuario").value = objData.data.idpersona;
                document.querySelector("#txtCodigo").value = objData.data.cod_producto;
                document.querySelector("#txtCantidad").value = objData.data.intCantidad;
                document.querySelector("#txtDescripcion").value = objData.data.strDescripcion;
            }
        }
        $('#modalFormResultado').modal('show');
    }
}


function fntDelInfo(cod_producto){
    swal({
        title: "Eliminar Resultado",
        text: "¿Realmente quiere eliminar el resultado?",
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
            let ajaxUrl = base_url+'/Resultado/delResultado';
            let strData = "cod_producto="+cod_producto;
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
                        tableResultado.api().ajax.reload();
                    }
                }
            }
        }
  
    });
  
  }

function openModal()
{
    rowTable = "";
    // document.querySelector('#idUsuario').value ="";
    document.querySelector('.modal-header').classList.replace("headerUpdate", "headerRegister");
    document.querySelector('#btnActionForm').classList.replace("btn-info", "btn-primary");
    document.querySelector('#btnText').innerHTML ="Guardar";
    document.querySelector('#titleModal').innerHTML = "Nuevo Resultado";
    document.querySelector("#formResultado").reset();
    $('#modalFormResultado').modal('show');
}