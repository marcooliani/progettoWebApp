$(document).ready(function() {
	function popoverContentCustomer() {
		// Non posso mettere il preventDefault,
		// altrimenti non si apre il popover.
		// Tocca tenere il "javascript:return false"
		// nell'html...

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
        url: '/api/customers/' + id.trim() +'/',
        method: 'GET',
        async: false,
        success:function(response) {
          content = $("#popover_customer").html();

          content = content.replace(/p_code/g, response.cust_code);
          content = content.replace(/p_name/g, response.cust_name);
          content = content.replace(/p_city/g, response.cust_city);
          content = content.replace(/p_country/g, response.cust_country);
          content = content.replace(/p_grade/g, response.grade);
        },
        error: function(response) {
        }
    });

    return content;
  }

	$('.popover_cli').popover({
      title: '<i class="fas fa-user"></i> About',
      html: true,
      placement: 'right',
      animation: true,
      trigger: 'click, focus',
      sanitize: true,
      content: popoverContentCustomer
  });
})
