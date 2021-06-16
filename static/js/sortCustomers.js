$(document).ready(function() {
  /*
   * Ordinamento colonne
   */
  $(".ordina").click(function(e) {
    e.preventDefault();

    sort = $(this).attr('sort');

    if(sort.charAt(0) != "-") {
      $(this).attr('sort', '-' + sort);
    }
    else {
      $(this).attr('sort', sort.substring(1));
    }

    $.ajax({
      url: '/api/customers/?sort_by=' + sort,
      type: 'GET',
      dataType: 'json',
      success: function(response) {
        // Svuoto il il tbody prima di fare l'append
        // delle righe ordinate!
        $('#customerTable').empty();
        var gruppo = $("[name='gruppo']").val()

        // Recupero i dati dall'oggetto response
        // restituito dalla chiamata all'API
        // e appendo le righe ordinate
        var len = response.length;

        for(var i=0; i<len; i++){
          var cust_code = response[i].cust_code;
          var cust_name = response[i].cust_name;
          var cust_city = response[i].cust_city;
          var cust_country = response[i].cust_country;
          var grade = response[i].grade;
          var agent_code = response[i].agent_code;
          var agent_name = response[i].agent_name;

          var tr_str = '<tr id="row_'+ cust_code + '">' +
              '<td>' + cust_code + '</td>' +
              '<td>' + cust_name + '</td>' +
              '<td>' + cust_city + '</td>' +
              '<td>' + cust_country + '</td>' +
              '<td>' + grade + '</td>';
          if(gruppo == "managers")
            tr_str = tr_str + '<td id="' + agent_code + '"><a href="javascript:return false;" class="popover_age" code="' + agent_code  + '">' + agent_name + '</td>';

          tr_str = tr_str + '<td class="nowrap"><a href="/clienti/' + cust_code + '/" title="Dettaglio cliente"><i class="fas fa-search"></i></a>' +
              '&nbsp;&nbsp;&nbsp;';
          tr_str = tr_str + '<td class="nowrap"><a href="#" title="Modifica cliente"><i class="fas fa-edit"></i></a>' +
              '&nbsp;&nbsp;&nbsp;';

          if(gruppo == "managers")
            tr_str = tr_str + '<a class="delete_order" id="' + cust_code + '" title="Elimina cliente"><i class="fas fa-trash-alt"></i></a></td>';
                
          tr_str = tr_str + '</tr>';

          $("#customerTable").append(tr_str);
        }
      },
      error(response) {
        console.log(response.responseText);
      }
    });

  });
})
