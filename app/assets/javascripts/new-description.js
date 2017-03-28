(function() {
  var showNotFound = function() {
    $('.dossier-link .text-info').hide();
    $('.dossier-link .text-warning').show();
  };

  var showData = function(data) {
    $('.dossier-link .procedureLibelle').text(data.procedureLibelle);
    $('.dossier-link .text-info').show();
    $('.dossier-link .text-warning').hide();
  };

  var hideEverything = function() {
    $('.dossier-link .text-info').hide();
    $('.dossier-link .text-warning').hide();
  };

  var fetchProcedureLibelle = function(e) {
    var dossierId = $(e.target).val();
    if(dossierId) {
      $.get('/api/v1/dossiers/' + dossierId + '/procedure_libelle')
        .done(showData)
        .fail(showNotFound);
    } else {
      hideEverything();
    }
  };

  $(document).on('change', '[data-type=dossier-link]', fetchProcedureLibelle);
})();
