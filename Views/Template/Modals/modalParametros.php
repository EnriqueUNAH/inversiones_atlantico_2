<!-- Modal -->
<div class="modal fade" id="modalFormParametros" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered" style="max-width: 500px;">
    <div class="modal-content">
      <div class="modal-header headerRegister">
        <h5 class="modal-title" id="titleModal">Nuevo Parámetro</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">


        <form id="formParametros" name="formParametros" class="form-horizontal">
          <input type="hidden" id="id_parametro" name="id_parametro" value="">
          <!--<p class="text-primary">Todos los campos son obligatorios.</p>-->
          <div class="form-row">
            <div class="form-group col-md-7">
              <label for="txtparametro">Parámetro</label>
              <input type="text" pattern="[a-zA-Z0-9_]+" class="form-control" id="txtparametro" name="txtparametro" style="text-transform:uppercase" required="" title="Ingrese solo letras y números sin espacios">
            </div>
          </div>
          <div class="form-row">

            <div class="form-group col-md-7">
              <label for="txtparametro">Valor</label>
              <input type="text" pattern="[A-Za-z0-9 ]+" class="form-control " id="txtvalor" name="txtvalor"  required="" title="Ingrese letras y números ">
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
<div class="modal fade" id="modalViewParametro" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header header-primary">
        <h5 class="modal-title" id="titleModal">Datos de los parámetros</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="table table-bordered">
          <tbody>
            <tr>
              <td>Parámetro:</td>
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