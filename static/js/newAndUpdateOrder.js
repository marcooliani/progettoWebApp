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

    // Controllo da quale form arrivano i dati e preparo i vari
    // parametri per la chiamata AJAX
    var form_id = '#'+ $('form').attr('id');

    if(form_id == "#new_order") {
      var url = '/api/orders/new/';
      var type = 'POST';
      var redir_page = '/ordini/nuovo/?p=success';
      var fail_msg = 'Ordine non inserito ';
    }
    else if(form_id == "#modify_order") {
      var ord_num = $('#ord_num').val();
      var url = '/api/orders/update/' + ord_num +  '/';
      var type = 'PUT';
      var redir_page = '/ordini/modifica/' + ord_num  + '/?p=success';
      var fail_msg = 'Update non riuscito ';
    }

    // Valido il form. Se è valido, manda la richiesta POST via AJAX
    if($(form_id)[0].checkValidity()) {

      // Prendo i campi del form e li salvo in un array associativo
      var form_data = $(form_id).serializeArray();
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
        url: url,
        type: type,
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
          window.location = redir_page;
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
              '<strong><i class="fas fa-times-circle"></i> Errore!</strong> ' + fail_msg +
                '<button type="button" class="btn-close" data-bs-dismiss="alert" ' +
                    'aria-label="Chiudi alert">' +
                '</button>' +
              '</div>');
          //$("#submit_result").html("message.responseText");
        }
      });
    }

    else {
        $(form_id)[0].reportValidity()
    } 

  });
})
