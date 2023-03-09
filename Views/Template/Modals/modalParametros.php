<!-- Modal -->
<div class="modal fade" id="modalFormParametros" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header headerRegister">
        <h5 class="modal-title" id="titleModal">Nuevo Parametro</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">


        <form id="formParametros" name="formParametros" class="form-horizontal">
          <input type="hidden" id="id_parametro" name="id_parametro" value="">
          <!--<p class="text-primary">Todos los campos son obligatorios.</p>-->
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="txtparametro">Parámetro</label>
              <input type="text" pattern="[a-zA-Z0-9_]+" class="form-control" id="txtparametro" name="txtparametro" style="text-transform:uppercase" required="" title="Ingrese solo letras y números sin espacios">
            </div>
          </div>
          <div class="form-row">

            <div class="form-group col-md-6">
              <label for="txtparametro">Valor</label>
              <input type="text" pattern="[a-zA-Z0-9_]+" class="form-control" id="txtvalor" name="txtvalor" style="text-transform:uppercase" required="" title="Ingrese solo letras y números sin espacios">
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