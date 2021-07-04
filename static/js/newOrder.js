$(document).ready(function() {
  // Limito la data del datepicker a oggi.
  // Per qualche motivo prende direttamente l'id del campo
  // senza bisogno del selettore in jQuery...
  ord_date.max = new Date().toISOString().split("T")[0];

  /* Avendo messo nei settings di Django CSRF_USE_SESSIONS = True
   * e CSRF_COOKIE_HTTPONLY = True, richiamo il token csrf semplicemente
   * dal campo (nascosto) html, che sarebbe poi rappresentato dalla 
   * istruzione {% csrf_token %} */
  const csrftoken = document.querySelector('[name=csrfmiddlewaretoken]').value;

  // Intercetto il click del bottone di invio del form
  $("#submit_order").click(function(event) {
    // Blocco l'invio del form
    event.preventDefault();

    // Valido il form. Se è valido, manda la richiesta POST via AJAX
    if($("#new_order")[0].checkValidity()) {

      // Prendo i campi del form e li salvo in un array associativo
      var form_data = $("#new_order").serializeArray();
      var _data = {};
      for (var i = 0; i < form_data.length; i++){
        _data[form_data[i]["name"]] = form_data[i]["value"];
      }

      // "Stringhifico" i dati dell'array associativo e 
      // converto il suddetto array in formato JSON
      // valido
      data = JSON.stringify(_data)

      // Richiesta AJAX
      $.ajax({
        url: '/api/orders/new/',
        type: 'POST',
        /* Passo il token csrf attaverso gli
        * header http, pena il 403 Forbidden */
        headers: {
          'X-CSRFToken': csrftoken
        },
        contentType: 'application/json',
        dataType: 'json',
        data: data,
        success: function() {
          // Redirect alla stessa pagina, ma con parametro p=success
          // per mostrare l'alert di avvenuto inserimento dell'ordine
          window.location = '/ordini/nuovo/?p=success';
        },
        error: function(message) {
        /* Potevo fare allo stesso modo del success, ma faccio
         * così per non dover ripassare i campi alla pagina
         * un'altra volta (in PHP l'avrei fatto, però!). Lo
         * tengo così, per l'uso che ne devo fare va bene lo stesso.
         * NOTA: message è uno degli oggetti ritornati dalla chiamata
         * e contiene vari campi tra cui responseText e responseJson
         */
          $("#submit_result").html(
            '<div class="alert alert-danger alert-dismissible fade show" role="alert">' +
              '<strong><i class="fas fa-times-circle"></i> Errore!</strong> Ordine non inserito ' +
                '<button type="button" class="btn-close" data-bs-dismiss="alert" ' +
                    'aria-label="Chiudi alert">' +
                '</button>' +
              '</div>');
          //$("#submit_result").html("message.responseText");
        }
      });
    }

    else {
        $("#new_order")[0].reportValidity()
    } 

  });
})
