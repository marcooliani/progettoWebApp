$.validator.addClassRules({
  name: {
    required: true,
    minlength: 2
  },
  zip: {
    required: true,
    digits: true,
    minlength: 5,
    maxlength: 5
  }
});

$(document).ready(function() {
  $('form').validate({

  });

})
