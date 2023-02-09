<?php

if (isset($_POST['btnCorreo'])) {
    include('_por_correo.php');
}

if (isset($_POST['btnPregunta'])) {
    include('validar.php');
}

?>




    <!-- The javascript plugin to display page loading on top-->
    <script src="<?= media(); ?>/js/plugins/pace.min.js"></script>
    <script type="text/javascript" src="<?= media();?>/js/plugins/sweetalert.min.js"></script>
    <script src="<?= media(); ?>/js/<?= $data['page_functions_js']; ?>"></script>
