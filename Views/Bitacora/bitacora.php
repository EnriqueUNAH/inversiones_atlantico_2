<?php
headerAdmin($data);
//getModal('modalUsuarios', $data);

// $servidor= "localhost";$usuario= "root";$password = "";$base= "db_inversiones_atlantico";
// $mysqli = new mysqli($servidor,$usuario,$password,$base);
// $connection = mysqli_connect($servidor,$usuario,$password,$base) or die("Error" . mysqli_error($connection));
// if($mysqli->connect_error){ echo "Nuestro sitio presenta fallas...."; die('Error en la conexion' . $mysqli->connect_error); exit();}


// $bitacora =  "select * from tbl_ms_bitacora ";
// $resultado = $mysqli->query($bitacora);


?>
<main class="app-content">
  <div class="app-title">
    <div>
      <h1><i class="fas fa-user-tag"></i> <?= $data['page_title'] ?>
        <?php if ($_SESSION['permisosMod']['w']) { ?>
          <!-- <button class="btn btn-primary" type="button" onclick="openModal();"><i class="fas fa-plus-circle"></i> Nuevo</button> -->
        <?php } ?>
      </h1>
    </div>
    <ul class="app-breadcrumb breadcrumb">
      <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
      <li class="breadcrumb-item"><a href="<?= base_url(); ?>/bitacora"><?= $data['page_title'] ?></a></li>
    </ul>
  </div>
  <input type="date" id="fechaInicio">
  <input type="date" id="fechaFin">
  <button id="btnBuscar">Buscar</button>

  <div class="row">
    <div class="col-md-12">
      <div class="tile">
        <div class="tile-body">
          <div class="table-responsive">
            <table class="table table-hover table-bordered" id="tableBitacora">
              <thead>
                <tr>
                  <th>Fecha</th>
                  <th>Usuario</th>
                  <th>Objeto</th>
                  <th>Acción</th>
                  <th>Descripción</th>

                </tr>
              </thead>
              <tbody>


              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</main>
<?php footerAdmin($data); ?>


<script>
  $("#btnBuscar").on("click", function() {
    var fechaInicio = $("#fechaInicio").val();
    var fechaFin = $("#fechaFin").val();

    tableBitacora
      .api()
      .ajax.url(
        base_url +
        "/Bitacora/getBitacoraPorFecha?fechaInicio=" +
        fechaInicio +
        "&fechaFin=" +
        fechaFin
      )
      .load();
  });
</script>