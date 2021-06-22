$(document).ready(function() {
  /*
   * Formatta la data da YYYY-mm-dd
   * a dd/mm/YYYY
   */
  function formatta_data(data) {
    // Scompongo la data in input
    var formattedDate = new Date(data);
    var d = formattedDate.getDate();

    // Aggiungo uno 0 davanti se il giorno è < 10
    if(d < 10) {
      d = '0' + d;
    }

    var m =  formattedDate.getMonth();
    var Y = formattedDate.getFullYear();

    m = m+1; // Per qualche motivo conta un mese in meno...

    // Stesso discorso del giorno, aggiungo uno zero
    // davanti al mese se questo è < 10
    if(m < 10) {
      m = '0' + m;
    }

    // Riformatto la data nel formato dd/mm/YYYY
    data = d + '/' + m + '/' + Y;

    return data;
  }

  /*
   * Ordinamento colonne
   */
  $(".ordina").click(function(e) {
    e.preventDefault();

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
        url: '/api/orders/?sort_by=' + sort,
        type: 'GET',
        dataType: 'json',
        success: function(response) {
          // Svuoto il il tbody prima di fare l'append
          // delle righe ordinate!
          $('#orderTable').empty();

          // Recupero il gruppo dell'utente, visto che le 
          // istruzioni di Django all'interno di un JS
          // esterno NON vengono richiamate...
          var gruppo = $("[name='gruppo']").val()

          // Recupero i dati dall'oggetto response
          // restituito dalla chiamata all'API
          // e appendo le righe ordinate
          var len = response.length;

          for(var i=0; i<len; i++){
                var ord_num = response[i].ord_num;
                var ord_date = response[i].ord_date;
                var ord_amount = response[i].ord_amount;
                var advance_amount = response[i].advance_amount;
                var cust_code = response[i].cust_code;
                var agent_code = response[i].agent_code;
                var cust_name = response[i].cust_name;
                var agent_name = response[i].agent_name;
                var ord_description = response[i].ord_description;

                var tr_str = '<tr id="row_'+ ord_num + '">' +
                    '<td>' + ord_num + '</td>' +
                    '<td>' + formatta_data(ord_date) + '</td>' +
                    '<td>' + ord_amount + '</td>' +
                    '<td>' + advance_amount + '</td>';
                if(gruppo == "agents" || gruppo == "managers")
                    tr_str = tr_str + '<td id="' + cust_code + '"><a href="javascript:void(0);" class="popover_cli" code="' + cust_code + '">' + cust_name + '</td>';
                
                if(gruppo == "customers" || gruppo == "managers")
                    tr_str = tr_str + '<td id="' + agent_code + '"><a href="javascript:void(0);" class="popover_age" code="' + agent_code  + '">' + agent_name + '</td>';
              
                tr_str = tr_str + '<td>' + ord_description + '</td>' +
                    '<td class="nowrap">'+
                    '<a href="/ordini/'+ ord_num + '" title="Dettaglio ordine"><i class="fas fa-search"></i></a>' +
                    '&nbsp;&nbsp;&nbsp;';

                if(gruppo == "agents" || gruppo == "managers") {
                    tr_str = tr_str + '<a href="/ordini/modifica/' + ord_num + '" title="Modifica ordine"><i class="fas fa-edit"></i></a>' +
                    '&nbsp;&nbsp;&nbsp;' +
                    '<a class="delete_order" id="' + ord_num + '" title="Elimina ordine"><i class="fas fa-trash-alt"></i></a>';
                }

                tr_str = tr_str + '</td>' +
                    '</tr> ';

                $("#orderTable").append(tr_str);

            }
        }
      });
  });
})
