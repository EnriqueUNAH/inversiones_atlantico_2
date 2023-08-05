<style>
    /* Definición de la animación */
    @keyframes borderAnimation {
      0% {
        box-shadow: 0 0 0 0 rgba(153, 51 , 255, 0.7); /* Morado */
      }
      25% {
        box-shadow: 0 0 0 10px rgba(153, 51 , 255, 0.7); /* Morado */
      }
      50% {
        box-shadow: 0 0 0 0 rgba(0, 255, 255, 0.7); /* Azul celeste */
      }
      75% {
        box-shadow: 0 0 0 10px rgba(0, 255, 255, 0.7); /* Azul celeste */
      }
      100% {
        box-shadow: 0 0 0 0 rgba(153, 51 , 255, 0.7); /*Morado */
      }
        }

        /* Estilos para el contenedor de la tarjeta */
        .tarjeta-container {
            position: relative; /* Importante para posicionar el pseudo-elemento */
        }

        /* Estilos para el pseudo-elemento que crea el borde animado */
        .tarjeta-container::before {
            content: '';
            position: absolute;
            top: -5px; /* Ajustar según el grosor deseado del borde animado */
            left: -5px; /* Ajustar según el grosor deseado del borde animado */
            right: -5px; /* Ajustar según el grosor deseado del borde animado */
            bottom: -5px; /* Ajustar según el grosor deseado del borde animado */
            border-radius: 5px; /* Ajustar según el radio de las esquinas de la tarjeta */
            animation: borderAnimation 10s infinite;
        }

        /* Estilos para el contenido de la tarjeta */
        .tarjeta-content {
            /* Asegúrate de que el contenido esté por encima del pseudo-elemento para que no lo cubra */
            position: relative;
            z-index: 1;
        }

        /* Otras estilizaciones para la tarjeta */
        .tarjeta-animated {
            /* Estilos de tu tarjeta */
            text-decoration: none; /* Quitamos subrayado del enlace */
            color: #333; /* Color del texto */
        }

        /* Estilos para el ícono */
        .tarjeta-animated .icon {
            margin: 10px; /* Espaciado del ícono */
        }

        /* Estilos para el título */
        .tarjeta-animated h4 {
            margin: 0;
            font-size: 18px;
        }

        /* Estilos para el párrafo */
        .tarjeta-animated p {
            margin: 0;
            font-size: 14px;
        }
    </style>


<?php headerAdmin($data); ?>
    <main class="app-content">
      <div class="app-title">
        <div>
          <h1><i class="fa fa-dashboard"></i><?= $data['page_title'] ?></h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
          <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
          <li class="breadcrumb-item"><a href="<?= base_url(); ?>/dashboard">Inicio</a></li>
        </ul>
      </div>
      <div class="row">
    <!-- /////////////////////////////////////////////////////////////////////////////////-->
  
    <?php if (!empty($_SESSION['permisos'][2]['r'])) { ?>
        <div class="col-md-6 col-lg-3">
            <div class="tarjeta-animated">
                <div class="tarjeta-container">
                    <!-- Contenido de la tarjeta -->
                    <a href="<?= base_url() ?>/usuarios" class="linkw">
                        <div class="widget-small primary coloured-icon">
                            <i class="icon fa fa-users fa-3x"></i>
                            <div class="info tarjeta-content">
                                <h4>Usuarios</h4>
                                <p><b><?= $data['usuarios'] ?></b></p>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    <?php } ?>
    <!-- /////////////////////////////////////////////////////////////////////////////////-->
        <?php if(!empty($_SESSION['permisos'][2]['r'])){ ?>
          <div class="col-md-6 col-lg-3">
            <div class="tarjeta-animated">
                <div class="tarjeta-container">
                    <!-- Contenido de la tarjeta -->
                    <a href="<?= base_url() ?>/clientes" class="linkw">
                        <div class="widget-small info coloured-icon">
                            <i class="icon fa fa-user fa-3x"></i>
                            <div class="info tarjeta-content">
                                <h4>Clientes</h4>
                                <p><b><?= $data['clientes'] ?></b></p>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    <!-- /////////////////////////////////////////////////////////////////////////////////-->

        <?php } ?>
        <!-- Contenedor de la tarjeta con borde animado -->
    <?php if (!empty($_SESSION['permisos'][4]['r'])) { ?>
        <div class="col-md-6 col-lg-3">
            <div class="tarjeta-container">
                <!-- Contenido de la tarjeta -->
                <a href="<?= base_url() ?>/productos" class="linkw tarjeta-animated">
                    <div class="widget-small warning coloured-icon">
                        <i class="icon fa fa fa-archive fa-3x"></i>
                        <div class="info tarjeta-content">
                            <h4>Productos</h4>
                            <p><b><?= $data['productos'] ?></b></p>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    <!-- /////////////////////////////////////////////////////////////////////////////////-->

    <?php if (!empty($_SESSION['permisos'][4]['r'])) { ?>
        <div class="col-md-6 col-lg-3">
            <div class="tarjeta-animated">
                <div class="tarjeta-container">
                    <!-- Contenido de la tarjeta -->
                    <a href="<?= base_url() ?>/compras" class="linkw">
                        <div class="widget-small danger coloured-icon">
                            <i class="icon fa fa fa-shopping-cart fa-3x"></i>
                            <div class="info tarjeta-content">
                                <h4>Compras</h4>
                                <p><b><?= $data['compras'] ?></b></p>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    <?php } ?>




        <?php } ?>
        


 
      </div>
   
      <div class="row">

        <div class="col-md-6">
          <div class="tile">
            <div class="container-title">
              <h3 class="tile-title">VISIÓN</h3>
                <div class="card card-primary">
            <div class="card-body">
            <p>
                <p>
                <h5>Llegar a ser una empresa muy reconocida a nivel mundial 
                por la calidad que ofrecemos en nuestros productos y 
                buen servicio que le brindamos a nuestros clientes.</h5>
                </p>

                <p>                            
            </div>                            
          </div>    
                <!-- <input class="date-picker ventasMes" name="ventasMes" placeholder="Mes y Año"> -->
                <!-- <button type="button" class="btnVentasMes btn btn-info btn-sm" onclick="fntSearchVMes()"> <i class="fas fa-search"></i> </button> -->
              </div>
          </div>
        </div>

        <div class="col-md-6">
          <div class="tile">
            <div class="container-title">
              <h3 class="tile-title">MISIÓN</h3>
               <div class="card">
            <div class="card-body">
            <p>
               <h5> Fabricar y comercializar uniformes y ropa deportiva a nivel nacional e internacional
               y ofrecer a nuestros clientes productos de alta calidad, para asi cumplir con las 
               necesidades de nuestros clientes ofreciendo mayor calidad y comodidad. </h5>
            </p>                               
            </div>                            
          </div>      

            </div>
          </div>
        </div>
      </div> 

    </main>
<?php footerAdmin($data); ?>

<script>

  Highcharts.chart('pagosMesAnio', {
      chart: {
          plotBackgroundColor: null,
          plotBorderWidth: null,
          plotShadow: false,
          type: 'pie'
      },
      title: {
          text: 'Ventas por tipo pago, <?= $data['pagosMes']['mes'].' '.$data['pagosMes']['anio'] ?>'
      },
      tooltip: {
          pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
      },
      accessibility: {
          point: {
              valueSuffix: '%'
          }
      },
      plotOptions: {
          pie: {
              allowPointSelect: true,
              cursor: 'pointer',
              dataLabels: {
                  enabled: true,
                  format: '<b>{point.name}</b>: {point.percentage:.1f} %'
              }
          }
      },
      series: [{
          name: 'Brands',
          colorByPoint: true,
          data: [
          <?php 
            foreach ($data['pagosMes']['tipospago'] as $pagos) {
              echo "{name:'".$pagos['tipopago']."',y:".$pagos['total']."},";
            }
           ?>
          ]
      }]
  });

  Highcharts.chart('graficaMes', {
      chart: {
          type: 'line'
      },
      title: {
          text: 'Ventas de <?= $data['ventasMDia']['mes'].' del '.$data['ventasMDia']['anio'] ?>'
      },
      subtitle: {
          text: 'Total Ventas <?= SMONEY.'. '.formatMoney($data['ventasMDia']['total']) ?> '
      },
      xAxis: {
          categories: [
            <?php 
                foreach ($data['ventasMDia']['ventas'] as $dia) {
                  echo $dia['dia'].",";
                }
            ?>
          ]
      },
      yAxis: {
          title: {
              text: ''
          }
      },
      plotOptions: {
          line: {
              dataLabels: {
                  enabled: true
              },
              enableMouseTracking: false
          }
      },
      series: [{
          name: 'Dato',
          data: [
            <?php 
                foreach ($data['ventasMDia']['ventas'] as $dia) {
                  echo $dia['total'].",";
                }
            ?>
          ]
      }]
  });
  
  Highcharts.chart('graficaAnio', {
      chart: {
          type: 'column'
      },
      title: {
          text: 'Ventas del año <?= $data['ventasAnio']['anio'] ?> '
      },
      subtitle: {
          text: 'Esdística de ventas por mes'
      },
      xAxis: {
          type: 'category',
          labels: {
              rotation: -45,
              style: {
                  fontSize: '13px',
                  fontFamily: 'Verdana, sans-serif'
              }
          }
      },
      yAxis: {
          min: 0,
          title: {
              text: ''
          }
      },
      legend: {
          enabled: false
      },
      tooltip: {
          pointFormat: 'Population in 2017: <b>{point.y:.1f} millions</b>'
      },
      series: [{
          name: 'Population',
          data: [
            <?php 
              foreach ($data['ventasAnio']['meses'] as $mes) {
                echo "['".$mes['mes']."',".$mes['venta']."],";
              }
             ?>                 
          ],
          dataLabels: {
              enabled: true,
              rotation: -90,
              color: '#FFFFFF',
              align: 'right',
              format: '{point.y:.1f}', // one decimal
              y: 10, // 10 pixels down from the top
              style: {
                  fontSize: '13px',
                  fontFamily: 'Verdana, sans-serif'
              }
          }
      }]
  });

</script>
    