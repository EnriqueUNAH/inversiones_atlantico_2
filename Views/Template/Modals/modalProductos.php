<!-- Modal -->
<div class="modal fade" id="modalFormProducto" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header headerRegister">
        <h5 class="modal-title" id="titleModal">Nuevo Producto</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">


        <style>
          .btn-outline-secondary {
            background-color: #0d6efd;
            color: white;
          }
        </style>

        <form id="formProducto" name="formProducto" class="form-horizontal">
          <input type="hidden" id="cod_producto" name="cod_producto" value="">
          <!--<p class="text-primary">Todos los campos son obligatorios.</p>-->
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="txtnombre">Nombre Producto</label>
              <input type="text" pattern="[a-zA-Z]+" class="form-control" id="txtnombre" name="txtnombre" style="text-transform:uppercase" required="" title="Ingrese solo letras sin espacios">
            </div>

           <div class="form-group col-md-6">
              <label for="txtdescripcion">Descripción</label>
              <input type="text" pattern="[a-zA-Z ]+" class="form-control valid validText" id="txtdescripcion" name="txtdescripcion" style="text-transform:uppercase" required="" title="No se puede ingresar números">
            </div>

          </div>
         

          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="intCantidadMin">Cantidad Mínima</label>
              <input  type="number" class="form-control" id="intCantidadMin" name="intCantidadMin" required="">
            </div>
            <div class="form-group col-md-6">
              <label for="intCantidadMax">Cantidad Máxima</label>
              <input type="number" class="form-control" id="intCantidadMax" name="intCantidadMax" required="">
            </div>

          
          </div>
          
          <div class="form-row">

            <div class="form-group col-md-6">
              <label for="listTipo">Tipo Producto</label>
              <select class="form-control" data-live-search="true" id="listTipo" name="listTipo" required>
              </select>
            </div>


            <div class="form-group col-md-6">
              <label for="intprecio">Precio</label>
              <input type="number" class="form-control" id="intprecio" name="intprecio" required="">
            </div>
          </div>


          <div class="form-row">

          <div class="form-group col-md-6">
              <label for="listStatus">Estado</label>
              <select class="form-control selectpicker" id="listStatus" name="listStatus" required>
                <option value="3">NUEVO</option>
                <option value="1">ACTIVO</option>
                <option value="2">INACTIVO</option>
              </select>
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






<!-- Modal del botón ver más-->
<div class="modal fade" id="modalViewProducto" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header header-primary">
        <h5 class="modal-title" id="titleModal">Datos del Producto</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="table table-bordered">
          <tbody>
            <tr>
              <td>Nombre Producto:</td>
              <td id="celNombre"></td>
            </tr>
            <tr>
              <td>Descripcion:</td>
              <td id="celDescripcion">J</td>
            </tr>
            <tr>
              <td>Cantidad Minima:</td>
              <td id="celCantMin"></td>
            </tr>
            <tr>
              <td>Cantidad Maxima:</td>
              <td id="celCantMax"></td>
            </tr>
            <tr>
              <td>Tipo Producto:</td>
              <td id="celTipoProducto"></td>
            </tr>
            <tr>
              <td>Precio:</td>
              <td id="celPrecio"></td>
            </tr>
            <tr>
              <td>Estado:</td>
              <td id="celEstado"></td>
            </tr>
            <tr>
              <td>Creado por:</td>
              <td id="celCreadoPor"></td>
            </tr>
            <tr>
              <td>Fecha de creación:</td>
              <td id="celFechaCreacion"></td>
            </tr>
            <tr>
              <td>Modificado por:</td>
              <td id="celModificadoPor">n</td>
            </tr>
            <tr>
              <td>Fecha de modificación:</td>
              <td id="celFechaModificacion"></td>
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