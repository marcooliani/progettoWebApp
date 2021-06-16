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
})

