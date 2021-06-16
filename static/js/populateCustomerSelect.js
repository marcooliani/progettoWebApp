$(document).ready(function() {
  const csrftoken = document.querySelector('[name=csrfmiddlewaretoken]').value;

  /*
   * Popolazione select clienti via AJAX
   */
  $('select#agent_code').change(function() {
    var agente = $('select#agent_code option:selected').attr('value');

    if(agente == '') {
      $('select#cust_code').empty();
      $('select#cust_code').html('<option value=""> --- </option>');
    }

    $.ajax({
      url: '/api/customers/?agent=' + agente,
      type: 'GET',
      headers: {
        'X-CSRFToken': csrftoken
      },
      success: function(response) {
        if(agente == '') {
          $('select#cust_code').empty();
          $('select#cust_code').html('<option value=""> --- </option>');
        }

        else {
          var data = '';
          var len = response.length;

          for(var i=0; i<len; i++){
            var cust_code = response[i].cust_code;
            var cust_name = response[i].cust_name;

            data = data + '<option value="' + cust_code + '">' + cust_name + '</option>';
          }

          $('select#cust_code').html(data);
        }
      },
      error: function(message) {
        console.log(message.responseText);
      }
    });
  });
})
