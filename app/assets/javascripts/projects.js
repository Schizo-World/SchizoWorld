$(document).ready(function(){

  /*$('#post_body').keyup(function() {
      if (event.keyCode == 13) {
          this.submit();
          return false;
       }
  });*/
  $('form#new_post')
    .live("ajax:success", function(e, data, x) {
      $('#posts').prepend(data);
    });
  $('form#new_post')
    .live("ajax:error", function(x, s, e) {
      alert("fail");
    })
    .live("ajax:complete", function(x, s) {
      $('#post_body').val("");
    });

});