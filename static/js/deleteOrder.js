$(document).ready(function() {
	/* Avendo messo nei settings di Django CSRF_USE_SESSIONS = True
   * e CSRF_COOKIE_HTTPONLY = True, richiamo il token csrf semplicemente
   * dal campo (nascosto) html, che sarebbe poi rappresentato dalla
   * istruzione {% csrf_token %} */
	const csrftoken = document.querySelector('[name=csrfmiddlewaretoken]').value;

	// Creo l'oggetto modal e lo lancio
	const myModal = new bootstrap.Modal(document.getElementById('modal_confirm'));

	/*
   * Cancellazione ordine. I casi sono due:
   * - se lascio $('.delete_order).click(), il metodo funziona
   * quando la pagina è caricata, ma smette di funzionare se
   * richiamato dentro conteneuti generati da una chiamata AJAX
   * (tipo il riordino delle tabelle, per capirci)
   * - la seconda soluzione funziona in tutti e due i casi, ma
   * è brutta a vedersi (forse la metto in un file separato
   * assieme alla "replica" delle funzioni popover...)
   */
  //$(".delete_order").click(function(e) {
  $('body').on('click', '.delete_order', function(e) {
    e.preventDefault();

    // recupero l'id dell'ordine da cancellare e
    // lo passo al modal
    ord = $(this).attr('id');
    $('#delete_confirm').attr('ordine', ord);
    $('#ordnum_modal').html(ord);

    myModal.show();

  });

	$('#delete_confirm').click(function(e) {
    e.preventDefault();

    ord = $(this).attr('ordine');

    myModal.hide();

    // Richiesta AJAX DELETE. Non servono dati JSON o altro,
    // ma il token csrf va passato anche in questo caso...
    $.ajax({
      url: "/api/orders/delete/" + ord + "/",
      type: 'DELETE',
      headers: {
        'X-CSRFToken': csrftoken
      },
      success: function(message) {
        $('#row_' + ord).fadeOut(300, function(){
          $(this).remove();
        })

        //$('#row_' + ord).remove();
      },
      error: function(message) {
        //alert(message.responseText)
      }

    })

  });
})
