<!-- Modal -->
<div class="modal fade" id="modalFormCai" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered" style="max-width: 500px;">
    <div class="modal-content">
      <div class="modal-header headerRegister">
        <h5 class="modal-title" id="titleModal">Nueva Configuracion CAI</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">


        <form id="formCai" name="formCai" class="form-horizontal">
          <input type="hidden" id="cod_talonario" name="cod_talonario" value="">
          <p class="text-primary">Todos los campos son obligatorios.</p>
          <div class="form-row">
            <div class="form-group col-md-7">
              <label for="txtRangoI">Rango Inicial</label>
              <input type="number" class="form-control" id="txtRangoI" name="txtRangoI" required="">
            </div>
            <div class="form-group col-md-7">
              <label for="txtRangoF">Rango Final</label>
              <input type="number" class="form-control" id="txtRangoF" name="txtRangoF" required="">
            </div>

          </div>

          <div class="form-row">

            <div class="form-group col-md-7">
              <label for="txtRangoA">Rango Actual</label>
              <input type="number" class="form-control" id="txtRangoA" name="txtRangoA" required="">
            </div>
            <div class="form-group col-md-7">
              <label for="txtnum">NUMERO CAI</label>
              <input type="text" pattern="[a-zA-Z0-9_]+" class="form-control" id="txtnum" name="txtnum" style="text-transform:uppercase" required="" title="Ingrese solo letras y números sin espacios">
            </div>

          </div>

          <div class="form-row">

            <div class="form-group col-md-7">
              <label for="txtFecha">Fecha vencimiento</label>
              <input type="datetime-local" class="form-control" id="txtFecha" name="txtFecha" required="">
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



<!-- Modal del botón VER MÁS-->
<div class="modal fade" id="modalViewCai" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header header-primary">
        <h5 class="modal-title" id="titleModal">Datos de CAI</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="table table-bordered">
          <tbody>
            <tr>
              <td>CAI:</td>
              <td id="elParametro"></td>
            </tr>
            <tr>
              <td>Valor:</td>
              <td id="elValor"></td>
            </tr>

            <tr>
              <td>Creado Por:</td>
              <td id="elCreadoPor"></td>
            </tr>
            <tr>
              <td>Fecha Creación:</td>
              <td id="elFechaCreacion"></td>
            </tr>
            <tr>
              <td>Modificado Por:</td>
              <td id="elModificadoPor"></td>
            </tr>
            <tr>
              <td>Fecha Modificación:</td>
              <td id="elFechaModificacion"></td>
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