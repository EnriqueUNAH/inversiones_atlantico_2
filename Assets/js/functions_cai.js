let tableCai; 
let rowTable = "";
let divLoading = document.querySelector("#divLoading");
document.addEventListener('DOMContentLoaded', function(){

    tableCai = $('#tableCai').dataTable( {
        "aProcessing":true,
        "aServerSide":true,
        "language": {
            "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
        },
        "ajax":{
            "url": " "+base_url+"/Cai/getCais",
            "dataSrc":""
        },
        "columns":[
            {"data":"cod_talonario"},
            {"data":"rango_inicial"},
            {"data":"rango_final"},
            {"data":"rango_actual"},
            {"data":"numero_CAI"},
            {"data":"fecha_vencimiento"},
            {"data":"options"}
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

	if(document.querySelector("#formCai")){
        let formCai = document.querySelector("#formCai");
        formCai.onsubmit = function(e) {
            e.preventDefault();
            let intIdCodigo = document.querySelector('#txtIdCodigo').value;
            let intRangoInicial = document.querySelector('#txtRangoIni').value;
            let intRangoFinal = document.querySelector('#txtRangoFin').value;
            let intRangoActual = document.querySelector('#txtRangoAct').value;
            let intCai = document.querySelector('#txtCai').value;
            let dateFecha = document.querySelector('#txtFecha').value;

            if(intRangoInicial == '' || intRangoFinal  == '' || intRangoActual == '' || intCai == '')
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
            let ajaxUrl = base_url+'/Cai/setCai'; 
            let formData = new FormData(formCai);
            request.open("POST",ajaxUrl,true);
            request.send(formData);
            request.onreadystatechange = function(){
                if(request.readyState == 4 && request.status == 200){
                    let objData = JSON.parse(request.responseText);
                    if(objData.status)
                    {
                        if(rowTable == ""){
                            tableCai.api().ajax.reload();
                        }else{
                           rowTable.cells[0].textContent =  cod_talonario;
                           rowTable.cells[1].textContent =  rango_inicial;
                           rowTable.cells[2].textContent =  rango_final;
                           rowTable.cells[3].textContent =  rango_actual;
                           rowTable.cells[4].textContent =  numero_CAI;
                           rowTable.cells[5].textContent =  fecha_vencimiento;
                           rowTable = "";
                        }
                        $('#modalFormCai').modal("hide");
                        formCai.reset();
                        swal("Cai", objData.msg ,"success");
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


function fntViewInfo(cod_talonario){
    let request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
    let ajaxUrl = base_url+'/Cai/getCai/'+cod_talonario;
    request.open("GET",ajaxUrl,true);
    request.send();
    request.onreadystatechange = function(){
        if(request.readyState == 4 && request.status == 200){
            let objData = JSON.parse(request.responseText);
            if(objData.status)
            {
                document.querySelector("#txtIdCodigo").innerHTML = objData.data.cod_talonario;
                document.querySelector("#txtRangoIni").innerHTML = objData.data.rango_inicial;
                document.querySelector("#txtRangoFin").innerHTML = objData.data.rango_final;
                document.querySelector("#txtRangoAct").innerHTML = objData.data.rango_actual;
                document.querySelector("#txtCai").innerHTML = objData.data.numero_CAI;
                document.querySelector("#txtFecha").innerHTML = objData.data.fecha_vencimiento;
                $('#modalViewCai').modal('show');
            }else{
                swal("Error", objData.msg , "error");
            }
        }
    }
}

function fntEditInfo(element, cod_talonario){
    rowTable = element.parentNode.parentNode.parentNode;
    document.querySelector('#titleModal').innerHTML ="Actualizar CAI";
    document.querySelector('.modal-header').classList.replace("headerRegister", "headerUpdate");
    document.querySelector('#btnActionForm').classList.replace("btn-primary", "btn-info");
    document.querySelector('#btnText').innerHTML ="Actualizar";
    let request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
    let ajaxUrl = base_url+'/Cai/getCai/'+cod_talonario;
    request.open("GET",ajaxUrl,true);
    request.send();
    request.onreadystatechange = function(){

        if(request.readyState == 4 && request.status == 200){
            let objData = JSON.parse(request.responseText);
            if(objData.status)
            {
                // document.querySelector("#idUsuario").value = objData.data.idpersona;
                document.querySelector("#txtIdCodigo").value = objData.data.cod_talonario;
                document.querySelector("#txtRangoIni").value = objData.data.rango_inicial;
                document.querySelector("#txtRangoFin").value = objData.data.rango_final;
                document.querySelector("#txtRangoAct").value = objData.data.rango_actual;
                document.querySelector("#txtCai").value = objData.data.numero_CAI;
                document.querySelector("#txtFecha").value = objData.data.fecha_vencimiento;
            }
        }
        $('#modalFormCai').modal('show');
    }
}


function fntDelInfo(cod_talonario){
    swal({
        title: "Eliminar Numero CAI",
        text: "¿Realmente quiere eliminar CAI?",
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
            let ajaxUrl = base_url+'/Cai/delCai';
            let strData = "cod_talonario="+cod_talonario;
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
                        tableCai.api().ajax.reload();
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
    document.querySelector('#titleModal').innerHTML = "Nuevo Cai";
    document.querySelector("#formCai").reset();
    $('#modalFormCai').modal('show');
}