<!-- Modal -->
<div class="modal fade" id="modalFormDescuentos" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered" style="max-width: 500px;">
    <div class="modal-content">
      <div class="modal-header headerRegister">
        <h5 class="modal-title" id="titleModal">Nuevo Descuento</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">


        <form id="formDescuento" name="formDescuento" class="form-horizontal">
          <input type="hidden" id="cod_descuento" name="cod_descuento" value="">
          <p class="text-primary">Todos los campos son obligatorios.</p> 
          <div class="form-row">
            <div class="form-group col-md-7">
              <label for="txtNombre">Nombre Descuento</label>
<input type="text" pattern="[a-zA-Z ]+" class="form-control valid validText" id="txtNombre" name="txtNombre" style="text-transform:uppercase" required="" title="Ingrese solo letras" maxlength="25" autocomplete="off" oninput = validarEspacios(this); onkeypress="return ((event.charCode >= 65 && event.charCode <= 90) || (event.charCode >= 97 && event.charCode <= 122) || (event.charCode<=32))">

                       </div>
          </div>

          <div class="form-row">
            <div class="form-group col-md-7">
              <label for="txtPorcentaje">Porcentaje</label>
              <input type="number" step="0.01" class="form-control" id="txtPorcentaje" name="txtPorcentaje" required="">
            </div>
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