<!-- Modal -->
<div class="modal fade" id="modalFormCai" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header headerRegister">
        <h5 class="modal-title" id="titleModal">Nuevo CAI</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">


        <form id="formCai" name="formCai" class="form-horizontal">
          <input type="hidden" id="cod_talonario" name="cod_talonario" value="">
          <p class="text-primary">Todos los campos son obligatorios.</p>
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="txtRangoI">Rango Inicial </label>
              <input type="number" class="form-control" id="txtRangoI" name="txtRangoI" required="" maxlength="19">
            </div>


            <div class="form-group col-md-6">
              <label for="txtRangoF">Rango Final</label>
              <input type="number" class="form-control" id="txtRangoF" name="txtRangoF" required="" maxlength="19">
            </div>

          </div>


          <div class="form-row">

           <div class="form-group col-md-6">
              <label for="txtRangoA">Rango Actual</label>
              <input type="number" class="form-control" id="txtRangoA" name="txtRangoA" required="" maxlength="19">

            </div>

          </div>

          <div class="form-row">

            <div class="form-group col-md-8">
              <label for="txtnum">Numero CAI</label>
              <input type="text" class="form-control" id="txtnum" name="txtnum" style="text-transform:uppercase" required="">

            </div>

            <div class="form-group col-md-3">
              <label for="txtFecha">fecha vencimiento </label>
              <input type="date" class="form-control" id="txtFecha" name="txtFecha" required="">
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