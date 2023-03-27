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
        <label type="hidden" for="txtIdCodigo"></label>
          <input type="hidden" id="txtIdCodigo" name="cod_talonario">
          <p class="text-primary">Todos los campos son obligatorios.</p>
          <div class="form-row">
            <div class="form-group col-md-7">
              <label for="txtRangoI">Rango Inicial</label>
              <input type="number" class="form-control" id="txtRangoIni" name="txtRangoIni" required="">
            </div>
            <div class="form-group col-md-7">
              <label for="txtRangoF">Rango Final</label>
              <input type="number" class="form-control" id="txtRangoFin" name="txtRangoFin" required="">
            </div>

          </div>

          <div class="form-row">

            <div class="form-group col-md-7">
              <label for="txtRangoA">Rango Actual</label>
              <input type="number" class="form-control" id="txtRangoAct" name="txtRangoAct" required="">
            </div>
            <div class="form-group col-md-7">
              <label for="txtnum">Numero CAI</label>
              <input type="text" pattern="[a-zA-Z0-9_]+" class="form-control" id="txtCai" name="txtCai" style="text-transform:uppercase" required="" title="Ingrese solo letras y números sin espacios">
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
              <td>rango inicial:</td>
              <td id="txtRangoIni"></td>
            </tr>
            <tr>
              <td>rango final:</td>
              <td id="txtRangoFin"></td>
            </tr>

            <tr>
              <td>rango actual:</td>
              <td id="txtRangoAct"></td>
            </tr>
            <tr>
              <td>CAI:</td>
              <td id="txtCai"></td>
            </tr>
            <tr>
              <td>Fecha:</td>
              <td id="txtFecha"></td>
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