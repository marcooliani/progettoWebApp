$(document).ready(function() {

  $.validator.addClassRules({
    ord_num: {
      required: true
    },
    ord_amount: {
      required: true,
      digits: true,
    },
    advance_amount: {
      required: true,
      digits:true
    },
    ord_date: {
      required: true
    },
    ord_description: {
      required: true,
      maxlength: 60
    }
  });

  $('form').validate({
     onclick: false,
     debug: true,
     onfocusout: function(element) {$(element).valid()}

  });

})
