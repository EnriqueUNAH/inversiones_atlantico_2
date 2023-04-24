    <!-- Sidebar menu-->
    <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
    <aside class="app-sidebar">
      <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="http://localhost/inversiones_atlantico_2/Assets/images/avatar.png" alt="User Image">
        <div>
          <p class="app-sidebar__user-name"><?= mb_convert_case($_SESSION['userData']['nombre_usuario'], MB_CASE_TITLE, "UTF-8"); ?></p>
          <p class="app-sidebar__user-designation"><?= mb_convert_case($_SESSION['userData']['nombrerol'], MB_CASE_TITLE, "UTF-8"); ?></p>
        </div>

      </div>
      <ul class="app-menu">

        <?php if (!empty($_SESSION['permisos'][1]['r'])) { ?>
          <li>
            <a class="app-menu__item" href="http://localhost/inversiones_atlantico_2/dashboard">
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


           <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
            <li><a class="treeview-item" href="http://localhost/inversiones_atlantico_2/ventas"><i class="icon fa fa-circle-o"></i> Ventas</a></li>
            <?php } ?>


           <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
              <li><a class="treeview-item" href="http://localhost/inversiones_atlantico_2/clientes"><i class="icon fa fa-circle-o"></i>Clientes</a></li>
            <?php } ?>


          </ul>
        </li>

        <!--################################VENTAS################################-->


<!--################################VENTAS################################-->



      <li class="treeview">
          <a class="app-menu__item" href="#" data-toggle="treeview">
            <i class="app-menu__icon fa fa-shopping-cart" aria-hidden="true"></i>


            <span class="app-menu__label ">Compras</span>
            <i class="treeview-indicator fa fa-angle-right"></i>
          </a>
          <ul class="treeview-menu">



          <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
              <li><a class="treeview-item" href="http://localhost/inversiones_atlantico_2/compras"><i class="icon fa fa-circle-o"></i>Compras</a></li>
            <?php } ?>

          </ul>
        </li>

        <!--################################VENTAS################################-->


    <!--################################VENTAS################################-->



    <li class="treeview">
          <a class="app-menu__item" href="#" data-toggle="treeview">
            <i class="app-menu__icon fa fa-hourglass-end" aria-hidden="true"></i>


            <span class="app-menu__label ">Producción</span>
            <i class="treeview-indicator fa fa-angle-right"></i>
          </a>
          <ul class="treeview-menu">



          <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
              <li><a class="treeview-item"  href="http://localhost/inversiones_atlantico_2/produccion"><i class="icon fa fa-circle-o"></i>Producciòn</a></li>
            <?php } ?>


          </ul>
        </li>

        <!--################################VENTAS################################-->












  



        <!--################################INVENTARIO################################-->

        <li class="treeview">
          <a class="app-menu__item" href="#" data-toggle="treeview">
            <i class="app-menu__icon fas fa-dolly-flatbed" aria-hidden="true"></i>

            <span class="app-menu__label">Inventario</span>
            <i class="treeview-indicator fa fa-angle-right"></i>
          </a>
          <ul class="treeview-menu">

            <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
              <li><a class="treeview-item" href="http://localhost/inversiones_atlantico_2/productos"><i class="icon fa fa-circle-o"></i>Productos</a></li>
            <?php } ?>

            <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
              <li><a class="treeview-item" href="http://localhost/inversiones_atlantico_2/inventarios"><i class="icon fa fa-circle-o"></i>Inventarios</a></li>
            <?php } ?>

            <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
              <li><a class="treeview-item" href="http://localhost/inversiones_atlantico_2/kardex"><i class="icon fa fa-circle-o"></i>Kardex</a></li>
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

            <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
              <li><a class="treeview-item" href="http://localhost/inversiones_atlantico_2/promocion"><i class="icon fa fa-circle-o"></i> Promocion</a></li>
            <?php } ?>

            <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
              <li><a class="treeview-item" href="http://localhost/inversiones_atlantico_2/preguntas"><i class="icon fa fa-circle-o"></i> Preguntas</a></li>
            <?php } ?>

            <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
              <li><a class="treeview-item" href="http://localhost/inversiones_atlantico_2/objetos"><i class="icon fa fa-circle-o"></i> Objetos</a></li>
            <?php } ?>

            <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
              <li><a class="treeview-item" href="http://localhost/inversiones_atlantico_2/descuentos"><i class="icon fa fa-circle-o"></i>Descuentos</a></li>
            <?php } ?>

            <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
              <li><a class="treeview-item" href="http://localhost/inversiones_atlantico_2/cai"><i class="icon fa fa-circle-o"></i>CAI</a></li>
            <?php } ?>

          </ul>
        </li>

        <!--################################MANTENIMIENTO################################-->


      <!--################################SEGURIDAD################################-->
      <?php if (
          !empty($_SESSION['permisos'][2]['r'])
          || !empty($_SESSION['permisos'][2]['r'])
          || !empty($_SESSION['permisos'][2]['r'])
          || !empty($_SESSION['permisos'][2]['r'])
          || !empty($_SESSION['permisos'][2]['r'])
        ) { ?>


          <li class="treeview">
            <a class="app-menu__item" href="#" data-toggle="treeview">
              <i class="app-menu__icon fas fa-lock" aria-hidden="true"></i>

              <span class="app-menu__label">Seguridad</span>
              <i class="treeview-indicator fa fa-angle-right"></i>
            </a>
            <ul class="treeview-menu">

              <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
                <li><a class="treeview-item" href="http://localhost/inversiones_atlantico_2/usuarios"><i class="icon fa fa-circle-o"></i> Usuarios</a></li>
              <?php } ?>

              <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
                <li><a class="treeview-item" href="http://localhost/inversiones_atlantico_2/roles"><i class="icon fa fa-circle-o"></i> Roles</a></li>
              <?php } ?>

              <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
                <li><a class="treeview-item" href="http://localhost/inversiones_atlantico_2/bitacora"><i class="icon fa fa-circle-o"></i> Bitacora</a></li>
              <?php } ?>

              <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
                <li><a class="treeview-item" href="http://localhost/inversiones_atlantico_2/parametros"><i class="icon fa fa-circle-o"></i> Parámetros</a></li>
              <?php } ?>

              <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
                <li><a class="treeview-item" href="http://localhost/inversiones_atlantico_2.../Respaldo/php/index.php"><i class="icon fa fa-circle-o"></i> Backup</a></li>
              <?php } ?>

            </ul>
          </li>
        <?php } ?>
        <!--################################SEGURIDAD################################-->



        <li>
          <a class="app-menu__item" href="http://localhost/inversiones_atlantico_2/logout">
            <i class="app-menu__icon fa fa-sign-out" aria-hidden="true"></i>
            <span class="app-menu__label">Salir</span>
          </a>
        </li>
      </ul>
    </aside>