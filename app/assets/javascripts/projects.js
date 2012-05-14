$(document).ready(function(){

  /*$('#post_body').keyup(function() {
      if (event.keyCode == 13) {
          this.submit();
          return false;
       }
  });*/
  $('#new_post').bind("ajax:beforeSend", function() {
      $('#post_body').val("Envoi en cours ...");
    }).bind("ajax:success", function(e, data, status, xhr) {
      alert();
    }).bind("ajax:error", function(x, s, e) {
      alert();
    }).bind("ajax:complete", function(x, s) {
      $('#post_body').val("");
  });


  $("#new_message").bind("click", function(e) {
    $.ajax("/messages/new").done(function(data) {
      div = jQuery("<div>", {
        id: "new_message_box"
      });
      div.appendTo("#new_message");
      div.html(data);
    });
    // ...
  });
});