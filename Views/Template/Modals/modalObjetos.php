<!-- Modal -->
<div class="modal fade" id="modalFormObjetos" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header headerRegister">
        <h5 class="modal-title" id="titleModal">Nuevo Objeto</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">


        <form id="formObjetos" name="formObjetos" class="form-horizontal">
          <input type="hidden" id="id_objeto" name="id_objeto" value="">
          <p class="text-primary">Todos los campos son obligatorios.</p>
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="txtobjeto">Objetos</label>
              <input type="text" pattern="[a-zA-Z ]+" class="form-control valid validText" id="txtobjeto" name="txtobjeto" style="text-transform:uppercase" required="" title="Ingrese solo letras sin números" maxlength="20" onkeypress="if(this.value.length == 20) return false; ">
            </div>
          </div>
          <div class="form-row">

            <div class="form-group col-md-6">
              <label for="txtdescripcion">Descripcion</label>
              <input type="text" pattern="[a-zA-Z ]+" class="form-control valid validText" id="txtdescripcion" name="txtdescripcion" style="text-transform:uppercase" required="" title="Ingrese solo letras sin números " maxlength="30" onkeypress="if(this.value.length == 30) return false; ">
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
