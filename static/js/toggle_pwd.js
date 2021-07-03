$(document).ready(function(){
  $("#toggle_pwd").click(function(){

    var input_type = $("#id_password").attr('type');

    if(input_type == "password") {
      $("#id_password").attr("type","text");
      $("#toggle_pwd").attr("title","Nascondi password");
      $("#toggle_pwd").html("Nascondi password <i class='fas fa-eye-slash'></i>");
    }
   
    else if(input_type == "text") {
      $("#id_password").attr("type","password");
      $("#toggle_pwd").attr("title","Mostra password");
      $("#toggle_pwd").html("Mostra password <i class='fas fa-eye'></i>");
    }
 
  });
});
