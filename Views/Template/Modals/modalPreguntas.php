<!-- Modal -->
<div class="modal fade" id="modalFormPreguntas" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered" style="max-width: 500px;">
    <div class="modal-content">
      <div class="modal-header headerRegister">
        <h5 class="modal-title" id="titleModal">Nuevo Pregunta</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">


        <form id="formPreguntas" name="formPreguntas" class="form-horizontal">
          <input type="hidden" id="id_pregunta" name="id_pregunta" value="">
          <!-- <p class="text-primary">Todos los campos son obligatorios.</p> -->
          <div class="form-row">
            <div class="form-group col-md-7">
              <label for="txtpregunta">Pregunta</label>
              <input type="text" pattern="[a-zA-Zá-úÁ-Ú ?]+" class="form-control valid validText" id="txtpregunta" name="txtpregunta" style="text-transform:uppercase" required="" title="Ingrese solo letras" maxlength="50" onkeypress="if(this.value.length == 50) return false; ">
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