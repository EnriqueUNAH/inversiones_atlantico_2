<!-- Modal -->
<div class="modal fade" id="modalFormDescuento" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg" >
    <div class="modal-content">
      <div class="modal-header headerRegister">
        <h5 class="modal-title" id="titleModal">Nuevo Descuento</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
            <form id="formDescuento" name="formDescuento" class="form-horizontal">
              <input type="hidden" id="idUsuario" name="idUsuario" value="">
              <p class="text-primary">Los campos con asterisco (<span class="required">*</span>) son obligatorios.</p>

              <div class="form-row">
                <div>
                  <label type="hidden" for="txtIdCodigo"></label>
                  <input type="hidden" class="form-control" id="txtIdCodigo" name="txtIdCodigo" required="">
                </div>
                <div class="form-group col-md-4">
                  <label for="txtNombre">Nombre Descuento<span class="required">*</span></label>
                  <input type="text" class="form-control valid validText" id="txtNombre" name="txtNombre" required="">
                </div>
              </div>
              <div class="form-row">
                <div class="form-group col-md-4">
                  <label for="txtPorcentaje">Porcentaje <span class="required">*</span></label>
                  <input type="number" step="0.01" class="form-control" id="txtPorcentaje" name="txtPorcentaje" required="">
                </div>
              </div>
              <hr>
              <!-- <p class="text-primary">Datos Fiscales.</p>-->
              <div class="form-row">
                <div class="form-group col-md-6">
                  <!-- <label>Identificación Tributaria <span class="required">*</span></label>
                  <input class="form-control" type="text" id="txtNit" name="txtNit" required=""> -->
                </div> 
                <div class="form-group col-md-6">
                  <!-- <label>Nombre fiscal <span class="required">*</span></label>
                  <input class="form-control" type="text" id="txtNombreFiscal" name="txtNombreFiscal" required=""> -->
                </div> 

                <div class="form-group col-md-12">
                  <!-- <label>Dirección fiscal <span class="required">*</span></label>
                  <input class="form-control" type="text" id="txtDirFiscal" name="txtDirFiscal" required=""> -->
                </div> 
                
              </div>
             <div class="form-row">
                
             </div>
              <div class="tile-footer">
                <button id="btnActionForm" class="btn btn-primary" type="submit"><i class="fa fa-fw fa-lg fa-check-circle"></i><span id="btnText">Guardar</span></button>&nbsp;&nbsp;&nbsp;
                <button class="btn btn-danger" type="button" data-dismiss="modal"><i class="fa fa-fw fa-lg fa-times-circle"></i>Cerrar</button>
              </div>
            </form>
      </div>
    </div>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="modalViewDescuento" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog" >
    <div class="modal-content">
      <div class="modal-header header-primary">
        <h5 class="modal-title" id="titleModal">Datos del Descuento</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="table table-bordered">
          <tbody>
            <tr>
              <!-- <td id="Codigo">Codigo descuento:</td>
              <td ></td> -->
            </tr>
            <tr>
              <td id="Nombre" >Nombre descuento:</td>
              <td ></td>
            </tr>
            <tr>
              <td id="Porcentaje">Porcentaje:</td>
              <td ></td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>

