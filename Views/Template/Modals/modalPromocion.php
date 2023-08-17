<!-- Modal -->
<div class="modal fade" id="modalFormPromocion" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header headerRegister">
        <h5 class="modal-title" id="titleModal">Nuevo Usuario</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">


        <form id="formPromocion" name="formPromocion" class="form-horizontal">
          <input type="hidden" id="cod_promocion" name="cod_promocion" value="">
          <p class="text-primary">Todos los campos son obligatorios.</p>
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="txtnombre_promocion">Nombre Promocion</label>
              <input type="text" pattern="[a-zA-Z0-9 ]+" class="form-control" id="txtnombre_promocion" name="txtnombre_promocion" style="text-transform:uppercase" required="" title="Ingrese solo letras y números ">
            </div>
          </div>

          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="txtpromocion">Fecha inicio</label>
              <input type="datetime-local" class="form-control" id="txtfecha_inicio" name="txtfecha_inicio" required="" >
            </div>

            <div class="form-group col-md-6">
              <label for="txtpromocion">Fecha final</label>
              <input type="datetime-local" class="form-control" id="txtfecha_final" name="txtfecha_final" required="" >
            </div>
          </div>

          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="txtpromocion">Precio venta </label>
              <input type="number" class="form-control" id="txtprecio_venta" name="txtprecio_venta" required="">
            </div>

            <div class="form-group col-md-6">
              <label for="listStatus">Estado</label>
              <select class="form-control selectpicker" id="listStatus" name="listStatus" required>
                <option value="1">ACTIVO</option>
                <option value="2">INACTIVO</option>

              </select>
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


