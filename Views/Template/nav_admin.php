    <!-- Sidebar menu-->
    <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
    <aside class="app-sidebar">
      <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="<?= media(); ?>/images/avatar.png" alt="User Image">
        <div>
          <p class="app-sidebar__user-name"><?= mb_convert_case($_SESSION['userData']['nombre_usuario'], MB_CASE_TITLE, "UTF-8"); ?></p>
          <p class="app-sidebar__user-designation"><?= mb_convert_case($_SESSION['userData']['nombrerol'], MB_CASE_TITLE, "UTF-8"); ?></p>
        </div>

      </div>
      <ul class="app-menu">

        <?php if (!empty($_SESSION['permisos'][1]['r'])) { ?>
          <li>
            <a class="app-menu__item" href="<?= base_url(); ?>/dashboard">
              <i class="app-menu__icon fa fa-home"></i>

              <span class="app-menu__label">Inicio</span>

            </a>
          </li>
        <?php } ?>





        <!--################################VENTAS################################-->



        <li class="treeview">
          <a class="app-menu__item" href="#" data-toggle="treeview">
            <i class="app-menu__icon fa fa-line-chart" aria-hidden="true"></i>


            <span class="app-menu__label ">Ventas</span>
            <i class="treeview-indicator fa fa-angle-right"></i>
          </a>
          <ul class="treeview-menu">

          <?php if (!empty($_SESSION['permisos'][MVENTA]['r'])) { ?>
            <li><a class="treeview-item" href="<?= base_url(); ?>/ventas"><i class="icon fa fa-circle-o"></i> Ventas</a></li>
          <?php } ?>

          </ul>
        </li>

        <!--################################VENTAS################################-->


        <li class="treeview">
          <a class="app-menu__item" href="#" data-toggle="treeview">
            <i class="app-menu__icon fa fa-shopping-cart" aria-hidden="true"></i>


            <span class="app-menu__label ">Compras</span>
            <i class="treeview-indicator fa fa-angle-right"></i>
          </a>
          <ul class="treeview-menu">

          <?php if (!empty($_SESSION['permisos'][MCOMPRA]['r'])) { ?>
              <li><a class="treeview-item" href="<?= base_url(); ?>/compras"><i class="icon fa fa-circle-o"></i>Compras</a></li>
          <?php } ?>

          </ul>
        </li>

        <!--################################VENTAS################################-->



        <li class="treeview">
           <a class="app-menu__item" href="#" data-toggle="treeview">
            <i class="app-menu__icon fa fa-hourglass-end" aria-hidden="true"></i>

            <span class="app-menu__label ">Producción</span>
            <i class="treeview-indicator fa fa-angle-right"></i>
          </a>
          <ul class="treeview-menu">

          <?php if (!empty($_SESSION['permisos'][MPRODUCCION]['r'])) { ?>
              <li><a class="treeview-item" href="<?= base_url(); ?>/produccion"><i class="icon fa fa-circle-o"></i>Producción</a></li>
          <?php } ?>


          </ul>
        </li>


        <!--################################INVENTARIO################################-->

        <li class="treeview">
          <a class="app-menu__item" href="#" data-toggle="treeview">
            <i class="app-menu__icon fas fa-dolly-flatbed" aria-hidden="true"></i>

            <span class="app-menu__label">Inventario</span>
            <i class="treeview-indicator fa fa-angle-right"></i>
          </a>
          <ul class="treeview-menu">

            <?php if (!empty($_SESSION['permisos'][MPRODUCTO]['r'])) { ?>
              <li><a class="treeview-item" href="<?= base_url(); ?>/productos"><i class="icon fa fa-circle-o"></i>Productos</a></li>
            <?php } ?>

            <?php if (!empty($_SESSION['permisos'][MINVENTARIO]['r'])) { ?>
              <li><a class="treeview-item" href="<?= base_url(); ?>/inventarios"><i class="icon fa fa-circle-o"></i>Inventarios</a></li>
            <?php } ?>

            <?php if (!empty($_SESSION['permisos'][MKARDEX]['r'])) { ?>
              <li><a class="treeview-item" href="<?= base_url(); ?>/kardex"><i class="icon fa fa-circle-o"></i>Kardex</a></li>
            <?php } ?>

            <?php if (!empty($_SESSION['permisos'][MCLIENTE]['r'])) { ?>
              <li><a class="treeview-item" href="<?= base_url(); ?>/clientes"><i class="icon fa fa-circle-o"></i>Clientes</a></li>
            <?php } ?>

          </ul>
        </li>

        <!--################################INVENTARIO################################-->





        <!--################################MANTENIMIENTO################################-->

        <li class="treeview">
          <a class="app-menu__item" href="#" data-toggle="treeview">
            <i class="app-menu__icon fas fa-tools" aria-hidden="true"></i>

            <span class="app-menu__label">Mantenimiento</span>
            <i class="treeview-indicator fa fa-angle-right"></i>
          </a>
          <ul class="treeview-menu">

            <?php if (!empty($_SESSION['permisos'][MPROMOCION]['r'])) { ?>
              <li><a class="treeview-item" href="<?= base_url(); ?>/promocion"><i class="icon fa fa-circle-o"></i> Promocion</a></li>
            <?php } ?>

            <?php if (!empty($_SESSION['permisos'][MPREGUNTA]['r'])) { ?>
              <li><a class="treeview-item" href="<?= base_url(); ?>/preguntas"><i class="icon fa fa-circle-o"></i> Preguntas</a></li>
            <?php } ?>

            <?php if (!empty($_SESSION['permisos'][MOBJETO]['r'])) { ?>
              <li><a class="treeview-item" href="<?= base_url(); ?>/objetos"><i class="icon fa fa-circle-o"></i> Objetos</a></li>
            <?php } ?>

            <?php if (!empty($_SESSION['permisos'][MCAI]['r'])) { ?>
              <li><a class="treeview-item" href="<?= base_url(); ?>/cai"><i class="icon fa fa-circle-o"></i>CAI</a></li>
            <?php } ?>

          </ul>
        </li>

        <!--################################MANTENIMIENTO################################-->

        

        <!--################################SEGURIDAD################################-->
      <?php if (
          !empty($_SESSION['permisos'][MUSUARIO]['r'])
          || !empty($_SESSION['permisos'][MROL]['r'])
          || !empty($_SESSION['permisos'][MBITACORA]['r'])
          || !empty($_SESSION['permisos'][MPARAMETRO]['r'])
          || !empty($_SESSION['permisos'][MBACKUP]['r'])


        ) { ?>


          <li class="treeview">
            <a class="app-menu__item" href="#" data-toggle="treeview">
              <i class="app-menu__icon fas fa-lock" aria-hidden="true"></i>

              <span class="app-menu__label">Seguridad</span>
              <i class="treeview-indicator fa fa-angle-right"></i>
            </a>
            <ul class="treeview-menu">

              <?php if (!empty($_SESSION['permisos'][MUSUARIO]['r'])) { ?>
                <li><a class="treeview-item" href="<?= base_url(); ?>/usuarios"><i class="icon fa fa-circle-o"></i> Usuarios</a></li>
              <?php } ?>

              <?php if (!empty($_SESSION['permisos'][MROL]['r'])) { ?>
                <li><a class="treeview-item" href="<?= base_url(); ?>/roles"><i class="icon fa fa-circle-o"></i> Roles</a></li>
              <?php } ?>

              <?php if (!empty($_SESSION['permisos'][MBITACORA]['r'])) { ?>
                <li><a class="treeview-item" href="<?= base_url(); ?>/bitacora"><i class="icon fa fa-circle-o"></i> Bitacora</a></li>
              <?php } ?>

              <?php if (!empty($_SESSION['permisos'][MPARAMETRO]['r'])) { ?>
                <li><a class="treeview-item" href="<?= base_url(); ?>/parametros"><i class="icon fa fa-circle-o"></i> Parámetros</a></li>
              <?php } ?>

              <?php if (!empty($_SESSION['permisos'][MBACKUP]['r'])) { ?>
                <li><a class="treeview-item" href="<?= base_url(); ?>.../Respaldo/php/index.php"><i class="icon fa fa-circle-o"></i> Backup</a></li>
              <?php } ?>

            </ul>
          </li>
        <?php } ?>
        <!--################################SEGURIDAD################################-->






        <li>
          <a class="app-menu__item" href="<?= base_url(); ?>/logout">
            <i class="app-menu__icon fa fa-sign-out" aria-hidden="true"></i>
            <span class="app-menu__label">Salir</span>
          </a>
        </li>
      </ul>
    </aside>