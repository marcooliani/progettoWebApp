$(document).ready(function() {
  function popoverContentAgent() {
    var content = '';
    var element = $(this);
    var id = element.attr("code");

    var gruppo = $("[name='gruppo']").val()

    // Fantastico, se faccio la chiamata senza l'opzione
    // async mi ritorna la variabile content vuota appena
    // fuori dalla success!
    // Però l'opzione è deprecated, stando ai messaggi
    // della console: siamo a posto... -__-
    $.ajax({
        url: '/api/agents/' + id.trim() +'/',
        method: 'GET',
        async: false,
        success:function(response) {
          content = $("#popover_agent").html();

          content = content.replace(/p_code/g, response.agent_code);
          content = content.replace(/p_name/g, response.agent_name);
          content = content.replace(/p_warea/g, response.working_area);
          content = content.replace(/p_commission/g, response.commission);
          content = content.replace(/p_phone/g, response.phone_no);
        },
        error: function(response) {
        }
    });

    return content;
  }

  $('.popover_age').popover({
      title: '<i class="fas fa-user-tie"></i> Agente',
      html: true,
      placement: 'right',
      animation: true,
      trigger: 'click, focus',
      sanitize: true,
      content: popoverContentAgent
  });
});
