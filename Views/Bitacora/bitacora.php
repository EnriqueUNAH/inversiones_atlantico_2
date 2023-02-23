<?php
headerAdmin($data);
//getModal('modalUsuarios', $data);
// $Id_objeto=8 ; 

//         $visualizacion= permiso_ver($Id_objeto);



// if ($visualizacion==0)
//  {
//    header('location:  ../vistas/pagina_principal_vista.php'); 
// }

// else

// {

//         bitacora::evento_bitacora($Id_objeto, $_SESSION['id_usuario'],'Ingreso' , 'A Bitacora del sistema');


// /* Manda a llamar todos las datos de la tabla para llenar el gridview  */
// $sql_tabla_bitacora=" select u.Usuario, b.Accion, b.Descripcion,Date_format(b.Fecha,'%Y-%m-%d') as Fecha from tbl_usuarios u, tbl_bitacora b where u.id_usuario=b.id_usuario ORDER BY b.Fecha DESC";
// $resultadotabla_bitacora = $mysqli->query($sql_tabla_bitacora);

 $servidor= "localhost";$usuario= "root";$password = "123456";$base= "db_inversiones_atlantico";
$mysqli = new mysqli($servidor,$usuario,$password,$base);
$connection = mysqli_connect($servidor,$usuario,$password,$base) or die("Error" . mysqli_error($connection));
if($mysqli->connect_error){ echo "Nuestro sitio presenta fallas...."; die('Error en la conexion' . $mysqli->connect_error); exit();}


$bitacora =  "select * from tbl_ms_bitacora ";
$resultado = $mysqli->query($bitacora);

?>
<main class="app-content">
  <div class="app-title">
    <div>
      <h1><i class="fas fa-user-tag"></i> <?= $data['page_title'] ?>
        <?php if ($_SESSION['permisosMod']['w']) { ?>
          <!--<button class="btn btn-primary" type="button" onclick="openModal();"><i class="fas fa-plus-circle"></i> Nuevo</button> -->
        <?php } ?>
      </h1>
    </div>
    <ul class="app-breadcrumb breadcrumb">
      <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
      <li class="breadcrumb-item"><a href="<?= base_url(); ?>/bitacora"><?= $data['page_title'] ?></a></li>
    </ul>
  </div>
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
                  <th>Accion</th>
                  <th>Descripcion</th>
                </tr>
              </thead>
              <tbody>
              
              <?php while($row = $resultado->fetch_array(MYSQLI_ASSOC)) { ?>
              
              <tr>
             
              <td><?php echo strtoupper($row['fecha']); ?></td>
              <td><?php echo strtoupper($row['id_usuario']); ?></td>
              <td><?php echo strtoupper($row['id_objeto']); ?></td>
              <td><?php echo strtoupper($row['accion']); ?></td>
              <td><?php echo strtoupper($row['descripcion']); ?></td>
             
             <?php } ?>
              </tr>


              </tbody
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</main>
<?php footerAdmin($data); ?>