$(document).ready(function() {
  /*
   * Ordinamento colonne
   */
  $(".ordina").click(function(event) {
    event.preventDefault();

    /*
     * Setto il tipo di ordinamento per la colonna
     * selezionata. A differenza delle normali query
     * SQL, Django non usa ASC o DESC per gli ordinamenti
     * crescenti/decrescenti, ma una semplicemente
     * nomecampo per l'ordinamento crescente e
     * -nomecampo per quelli decrescenti. L'unico modo
     * per tenere traccia di quale ordinamento si sta
     * visualizzando ora per una data colonna è sostituire
     * il campo "sort" appositamente messo nel tag <span>
     * di ogni colonna
     */
    sort = $(this).attr('sort');

    // Controllo se il primo carattere della stringa è "-":
    // se non lo è, aggiungo il "-" alla stringa, per
    // poter poi eventualmente fare l'ordinamento
    // decrescente per la colonna considerata,
    // altrimento lo tolgo per fare poi l'ordinamento
    // crescente
    if(sort.charAt(0) != "-") {
      $(this).attr('sort', '-' + sort);
    }
    else {
      $(this).attr('sort', sort.substring(1));
    }

    // Richiesta AJAX GET per recuperare i dati
    // di tutti gli ordini
    $.ajax({
        url: '/api/agents/?sort_by=' + sort,
        type: 'GET',
        dataType: 'json',
        success: function(response) {
          // Svuoto il il tbody prima di fare l'append
          // delle righe ordinate!
          $('#agentsTable').empty();

          // Recupero i dati dall'oggetto response
          // restituito dalla chiamata all'API
          // e appendo le righe ordinate
          var len = response.length;

          for(var i=0; i<len; i++){
            var agent_code = response[i].agent_code;
            var agent_name = response[i].agent_name;
            var working_area = response[i].working_area;
            var country = response[i].country;
            var commission = response[i].commission;
            var phone_no = response[i].phone_no;

            var tr_str = '<tr id="row_'+ agent_code + '">' +
                '<td tabindex="0">' + agent_code + '</td>' +
                '<td tabindex="0">' + agent_name + '</td>' +
                '<td tabindex="0">' + working_area + '</td>' +
                '<td tabindex="0">' + country + '</td>' +
                '<td tabindex="0">' + commission + '</td>' +
                '<td tabindex="0">' + phone_no + '</td>' +
                '<td class="nowrap">' +
                '<a href="/agenti/' + agent_code.trim() + '/" title="Dettagli '+ agent_name +'"><i class="fas fa-search"></i></a>' +
                '&nbsp;&nbsp;&nbsp;' +
                '<a href="javascript:void(0)" title="Modifica '+ agent_name +'"><i class="fas fa-edit"></i></a>' +
                '&nbsp;&nbsp;&nbsp;' +
                '<a href="javascript:void(0)" class="delete_agent" id="' + agent_code.trim() + '" title="Elimina '+ agent_name +'"><i class="fas fa-trash-alt"></i></a></td>' +
                '</tr>';

            $("#agentsTable").append(tr_str);
          }
        },
        error(response) {
          console.log(response.responseText);
        }
      });
  });
});
