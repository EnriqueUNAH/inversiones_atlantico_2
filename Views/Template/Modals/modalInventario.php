<!-- Modal del botón ver más-->
<div class="modal fade" id="modalViewInventario" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header header-primary">
        <h5 class="modal-title" id="titleModal">Entradas y salidas</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="table table-bordered">
          <tbody>
            <tr>
              <td>Fecha:</td>
              <td id="celFecha"></td>
            </tr>
            <tr>
              <td>Tipo Movimiento:</td>
              <td id="celMovimiento">J</td>
            </tr>
            <tr>
              <td>Producto:</td>
              <td id="celProducto"></td>
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