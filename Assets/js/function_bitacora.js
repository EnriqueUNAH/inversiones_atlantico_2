let tableBitacora;
let rowTable = "";
let divLoading = document.querySelector("#divLoading");
document.addEventListener(
  "DOMContentLoaded",
  function () {
    tableBitacora = $("#tableBitacora").dataTable({
      aProcessing: true,
      aServerSide: true,
      language: {
        url: "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json",
      },
      ajax: {
        url: " " + base_url + "/Bitacora/getBitacora",
        dataSrc: "",
      },
      columns: [
        { data: "fecha" },
        { data: "id_usuario" },
        { data: "id_objeto" },
        { data: "accion" },
        { data: "descripcion" },
      ],
      dom: "lBfrtip",
      buttons: [
        {
          extend: "excelHtml5",
          text: "<i class='fas fa-file-excel'></i> Excel",
          titleAttr: "Exportar a Excel",
          className: "btn btn-success",
          exportOptions: {
            columns: [0, 1, 2, 3, 4],
          },
        },
        {
          extend: "pdfHtml5",
          text: "<i class='fas fa-file-pdf'></i> PDF",
          titleAttr: "Exportar a PDF",
          className: "btn btn-danger",
          exportOptions: {
            columns: [0, 1, 2, 3, 4],
          },
        },
      ],
      resonsieve: "true",
      bDestroy: true,
      iDisplayLength: 10,
      order: [[0, "desc"]],
    });


  },
  false
);




