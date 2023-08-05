    <script>
      const base_url = "<?= base_url(); ?>";
      const smony = "<?= SMONEY; ?>";
    </script>
    <!-- Essential javascripts for application to work-->
    <script src="<?= media(); ?>/js/jquery-3.3.1.min.js"></script>
    <script src="<?= media(); ?>/js/popper.min.js"></script>
    <script src="<?= media(); ?>/js/bootstrap.min.js"></script>
    <script src="<?= media(); ?>/js/main.js"></script>
    <script src="<?= media(); ?>/js/fontawesome.js"></script>
    <!-- The javascript plugin to display page loading on top-->
    <script src="<?= media(); ?>/js/plugins/pace.min.js"></script>
    <!-- Page specific javascripts-->
    <script type="text/javascript" src="<?= media(); ?>/js/plugins/sweetalert.min.js"></script>
    <script type="text/javascript" src="<?= media(); ?>/js/tinymce/tinymce.min.js"></script>

    <!-- Data table plugin-->

    <script src="http://localhost/inversiones_atlantico_2/Views/venta/js/functions.js"></script>


    <script type="text/javascript" src="<?= media(); ?>/js/plugins/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="<?= media(); ?>/js/plugins/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript" src="<?= media(); ?>/js/plugins/bootstrap-select.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="<?= media(); ?>/js/datepicker/jquery-ui.min.js"></script>
    <script type="text/javascript" src="<?= media(); ?>/js/functions_admin.js"></script>
    <script src="<?= media(); ?>/js/<?= $data['page_functions_js']; ?>"></script>

    <!-- Para usar máscaras de entrada -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/5.0.6/jquery.inputmask.min.js"></script>



    <!-- Incluimos la biblioteca jsPDF -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>

    <!-- Modal para confirmar permanencia en línea -->
    <div class="modal" tabindex="-1" role="dialog" id="stayOnlineModal">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">¿Desea permanecer en línea?</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            Su sesión está a punto de expirar debido a la inactividad. ¿Desea permanecer en línea?
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar sesión</button>
            <button type="button" class="btn btn-primary" data-dismiss="modal" id="stayOnlineBtn">Permanecer en línea</button>
          </div>
        </div>
      </div>
    </div>

    
<script>
  var baseUrl = "http://localhost/inversiones_atlantico_2"; // Cambia esto por la URL base de tu aplicación
</script>


    <script>
      var inactivityTimeout = 15 * 60 * 1000; // 5 minutos en milisegundos
      var logoutTimer;
      var modalTimeout = 30 * 1000; // 30 segundos en milisegundos (tiempo para mostrar el modal)

      
      function logout() {
        // Aquí puedes realizar las acciones necesarias para cerrar la sesión, como redireccionar a la página de inicio de sesión o limpiar los datos de sesión
     //window.location.href = "http://localhost/inversiones_atlantico_2/logout";
     window.location.href = baseUrl + "/logout";
    }

      function resetLogoutTimer() {
        clearTimeout(logoutTimer);
        logoutTimer = setTimeout(showStayOnlineModal, inactivityTimeout);
      }

      function showStayOnlineModal() {
        $('#stayOnlineModal').modal('show');
        // Esperar el tiempo del modal para cerrar la sesión si no hay respuesta del usuario
        setTimeout(logout, modalTimeout);
      }

      // Restablecer el temporizador en eventos de interacción del usuario
      document.addEventListener('click', resetLogoutTimer);
      document.addEventListener('mousemove', resetLogoutTimer);
      document.addEventListener('keypress', resetLogoutTimer);

      // Iniciar el temporizador al cargar la página
      resetLogoutTimer();

      // Asignar acción al botón "Permanecer en línea"
      document.getElementById('stayOnlineBtn').addEventListener('click', function() {
        clearTimeout(logoutTimer); // Detener el cierre de sesión
        $('#stayOnlineModal').modal('hide'); // Ocultar el modal
        resetLogoutTimer(); // Reiniciar el temporizador de inactividad
      });
    </script>

    </body>

    </html>