<!-- Modal -->
<div class="modal fade" id="modalFormCompra" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header headerRegister">
        <h5 class="modal-title" id="titleModal">Nuevo Usuario</h5>
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

        <form id="formCompra" name="formCompra" class="form-horizontal">
          <input type="hidden" id="cod_compra" name="cod_compra" value="">
          <!--<p class="text-primary">Todos los campos son obligatorios.</p>-->
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="txtusuario">Usuario</label>
              <input type="text" pattern="[a-zA-Z]+" class="form-control" id="txtusuario" name="txtusuario" style="text-transform:uppercase" required="" title="Ingrese solo letras sin espacios">
            </div>
          </div>
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="txtnombre_usuario">Nombre</label>
              <input type="text" pattern="[a-zA-Z ]+" class="form-control valid validText" id="txtnombre_usuario" name="txtnombre_usuario" style="text-transform:uppercase" required="" title="No se puede ingresar números">
            </div>
            <div class="form-group col-md-6">
              <label for="listid_rol">Rol</label>
              <select class="form-control" data-live-search="true" id="listid_rol" name="listid_rol" required>
              </select>
            </div>

          </div>
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="txtEmail">Correo Electrónico</label>
              <input type="email" class="form-control valid validEmail" id="txtEmail" name="txtEmail" required="">
            </div>
            <div class="form-group col-md-6">
              <label for="listStatus">Estado</label>
              <select class="form-control selectpicker" id="listStatus" name="listStatus" required>
                <option value="3">NUEVO</option>
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





<!-- Modal del botón ver más-->
<div class="modal fade" id="modalViewCompra" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header header-primary">
        <h5 class="modal-title" id="titleModal">Datos del usuario</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="table table-bordered">
          <tbody>
            <tr>
              <td>Usuario:</td>
              <td id="celusuario">654654654</td>
            </tr>
            <tr>
              <td>Nombre:</td>
              <td id="celNombre">Jacob</td>
            </tr>

            <tr>
              <td>Preguntas Contestadas:</td>
              <td id="celpreguntas_contestadas">Larry</td>
            </tr>
            <tr>
              <td>Correo Electrónico:</td>
              <td id="celEmail"></td>
            </tr>
            <tr>
              <td>Rol:</td>
              <td id="celTipoUsuario"></td>
            </tr>
            <tr>
              <td>Estado:</td>
              <td id="celEstado"></td>
            </tr>
            <tr>
              <td>Primer Ingreso:</td>
              <td id="celPrimerIngreso"></td>
            </tr>
            <tr>
              <td>Última Conexión:</td>
              <td id="celFechaUltimaConexion"></td>
            </tr>
            <tr>
              <td>Fecha Vencimiento:</td>
              <td id="celFechaVencimiento"></td>
            </tr>
            <tr>
              <td>Creado por:</td>
              <td id="celCreadoPor"></td>
            </tr>
            <tr>
              <td>Fecha de creación:</td>
              <td id="celFechaRegistro"></td>
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