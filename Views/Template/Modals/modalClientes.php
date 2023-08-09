<!-- Modal -->
<div class="modal fade" id="modalFormCliente" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header headerRegister">
        <h5 class="modal-title" id="titleModal">Nuevo Cliente</h5>
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

        <form id="formCliente" name="formCliente" class="form-horizontal">
          <input type="hidden" id="cod_cliente" name="cod_cliente" value="">
          <p class="text-primary">Los campos con asterisco (<span class="required">*</span>) son obligatorios.</p>
          <div class="form-row">
          <div class="form-group col-md-6">
              <label for="txtRtn">RTN</label>
              <input type="tel" class="form-control" autocomplete="off" id="txtRtn" name="txtRtn" maxlength="14"
              oninput="this.value = this.value.replace(/[^0-9]/g, '').substring(0, 14);">
          </div>

           <div class="form-group col-md-6">
              <label for="txtNombres">Nombre Completo <span class="required">*</span></label>
              <input type="text" pattern="[a-zA-Z ]+" class="form-control valid validText" id="txtNombres" name="txtNombres" style="text-transform:uppercase" required="" title="No se puede ingresar números" autocomplete="off">
            </div>

          </div>
          

          <div class="form-row">

          <div class="form-group col-md-6">
            <label for="txtTelefono">Teléfono</label>
            <input type="tel" class="form-control" autocomplete="off" id="txtTelefono" name="txtTelefono" maxlength="8" 
            oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^0+/, '').substring(0, 8);">
          </div>

            <div class="form-group col-md-6">
              <label for="txtEmail">Correo Electrónico</label>
              <input type="email" autocomplete="off" class="form-control valid validEmail" id="txtEmail" name="txtEmail" >
            </div>

          </div>

          <div class="form-row">

            <div class="form-group col-md-6">
              <label for="txtDireccion">Dirección</label>
              <input type="text" autocomplete="off" class="form-control" id="txtDireccion" name="txtDireccion" style="text-transform:uppercase" >
             </div>


             <!-- <div class="form-group col-md-6">
              <label for="listGenero">Genero<span class="required">*</span></label>
              <select class="form-control" data-live-search="true" id="listGenero" name="listGenero" required>
              </select> -->
              <!-- </div> -->
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
<div class="modal fade" id="modalViewCliente" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header header-primary">
        <h5 class="modal-title" id="titleModal">Datos del Cliente</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="table table-bordered">
          <tbody>
          <tr>
              <td>RTN:</td>
              <td id="celRtn"></td>
            </tr>

            <tr>
              <td>Nombre Completo:</td>
              <td id="celNombres"></td>
            </tr>

            <tr>
              <td>Telefono:</td>
              <td id="celTelefono"></td>
            </tr>

            <tr>
              <td>correo Electronico:</td>
              <td id="celEmail"></td>
            </tr>

            <tr>
              <td>Direccion:</td>
              <td id="celDireccion"></td>
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