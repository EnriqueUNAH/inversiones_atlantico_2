<?php
const BASE_URL = "http://localhost/inversiones_atlantico_2";

//Zona horaria
date_default_timezone_set('America/Guatemala');

//Datos de conexión a Base de Datos
const DB_HOST = "localhost";
const DB_NAME = "db_inversiones_atlantico";
const DB_USER = "root";
const DB_PASSWORD = "123456";
const DB_CHARSET = "utf8";

//Para envío de correo
const ENVIRONMENT = 1; // Local: 0, Produccón: 1;

//Deliminadores decimal y millar Ej. 24,1989.00
const SPD = ".";
const SPM = ",";

//Simbolo de moneda
const SMONEY = "L";
const CURRENCY = "LPS";

//Api PayPal
//SANDBOX PAYPAL
const URLPAYPAL = "https://api-m.sandbox.paypal.com";
const IDCLIENTE = "";
const SECRET = "";
//LIVE PAYPAL
//const URLPAYPAL = "https://api-m.paypal.com";
//const IDCLIENTE = "";
//const SECRET = "";

//Datos envio de correo
const NOMBRE_REMITENTE = "Inversiones Atlantico";
const EMAIL_REMITENTE = "no-reply@abelosh.com";
const NOMBRE_EMPESA = "Inversiones Atlantico";
const WEB_EMPRESA = "www.inversionesatlantico.com";

const DESCRIPCION = "La mejor tienda en línea con artículos de moda.";
const SHAREDHASH = "InversionesAtlantico";

//Datos Empresa
const DIRECCION = "Tela, Atlántida";
const TELEMPRESA = "+(502)78787845";
const WHATSAPP = "+50278787845";
const EMAIL_EMPRESA = "info@inversiones.com";
const EMAIL_PEDIDOS = "info@inversiones.com";
const EMAIL_SUSCRIPCION = "info@inversiones.com";
const EMAIL_CONTACTO = "info@inversiones.com";

const CAT_SLIDER = "1,2,3";
const CAT_BANNER = "4,5,6";
const CAT_FOOTER = "1,2,3,4,5";

//Datos para Encriptar / Desencriptar
const KEY = 'abelosh';
const METHODENCRIPT = "AES-128-ECB";

//Envío
const COSTOENVIO = 5;

// //Módulos
// const MDASHBOARD = 1;
// const MUSUARIOS = 2;
// const MCLIENTES = 3;
// const MPRODUCTOS = 4;
// const MPEDIDOS = 5;
// const MCATEGORIAS = 6;
// const MSUSCRIPTORES = 7;
// const MDCONTACTOS = 8;
// const MDPAGINAS = 9;

//Módulos

const MBACKUP = 1;
const MBITACORA = 2;
const MCAI = 4;
const MCLIENTE = 10;
const MCOMPRA = 11;
const MDESCUENTO = 12;
const MINICIO = 13;
const MINVENTARIO = 14;
const MKARDEX = 15;
const MOBJETO = 16;
const MPARAMETRO = 17;
const MPREGUNTA = 18;
const MPRODUCCION = 20;
const MPRODUCTO = 21;
const MPROMOCION = 22;
const MROL = 23;
const MUSUARIO = 24;
const MVENTA = 25;





//Roles
const RADMINISTRADOR = 1;
const RSUPERVISOR = 2;
const RCLIENTES = 3;

const STATUS = array('Completo', 'Aprobado', 'Cancelado', 'Reembolsado', 'Pendiente', 'Entregado');

//Productos por página
const CANTPORDHOME = 8;
const PROPORPAGINA = 4;
const PROCATEGORIA = 4;
const PROBUSCAR = 4;

//REDES SOCIALES
const FACEBOOK = "https://www.facebook.com/abelosh";
const INSTAGRAM = "https://www.instagram.com/febel24/";
