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
              <i class="app-menu__icon fa fa-dashboard"></i>

              <span class="app-menu__label">Inicio</span>
            </a>
          </li>
        <?php } ?>

        <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
          <li class="treeview">
            <a class="app-menu__item" href="#" data-toggle="treeview">
              <i class="app-menu__icon fa fa-users" aria-hidden="true"></i>
              <span class="app-menu__label">Seguridad</span>
              <i class="treeview-indicator fa fa-angle-right"></i>
            </a>
            <ul class="treeview-menu">
              <li><a class="treeview-item" href="<?= base_url(); ?>/usuarios"><i class="icon fa fa-circle-o"></i> Usuarios</a></li>
              <li><a class="treeview-item" href="<?= base_url(); ?>/roles"><i class="icon fa fa-circle-o"></i> Roles</a></li>
              <li><a class="treeview-item" href="<?= base_url(); ?>/bitacora"><i class="icon fa fa-circle-o"></i> Bitacora</a></li>
              <li><a class="treeview-item" href="<?= base_url(); ?>/parametros"><i class="icon fa fa-circle-o"></i> Parámetros</a></li>
            </ul>
          </li>
        <?php } ?>

        <?php if (!empty($_SESSION['permisos'][3]['r'])) { ?>
          <li class="treeview">
            <a class="app-menu__item" href="#" data-toggle="treeview">
              <i class="app-menu__icon fa fa-users" aria-hidden="true"></i>
              <span class="app-menu__label">Mantenimiento</span>
              <i class="treeview-indicator fa fa-angle-right"></i>
            </a>
            <ul class="treeview-menu">
              <li><a class="treeview-item" href="<?= base_url(); ?>/promocion"><i class="icon fa fa-circle-o"></i> Promocion</a></li>
              <li><a class="treeview-item" href="<?= base_url(); ?>/preguntas"><i class="icon fa fa-circle-o"></i> Preguntas</a></li>
              <li><a class="treeview-item" href="<?= base_url(); ?>/objetos"><i class="icon fa fa-circle-o"></i> Objetos</a></li>

            </ul>
          </li>
        <?php } ?>







        <li>
          <a class="app-menu__item" href="<?= base_url(); ?>/logout">
            <i class="app-menu__icon fa fa-sign-out" aria-hidden="true"></i>
            <span class="app-menu__label">Salir</span>
          </a>
        </li>
      </ul>
    </aside>