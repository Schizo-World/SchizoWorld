$(document).ready(function(){

  /*$('#post_body').keyup(function() {
      if (event.keyCode == 13) {
          this.submit();
          return false;
       }
  });*/
  $('#new_post')
    .live("ajax:success", function(e, data, x) {
      alert(data);
      $('#posts').prepend(data);
    }).live("ajax:error", function(x, s, e) {
      alert("fail");
    })
    .live("ajax:complete", function(x, s) {
      $('#post_body').val("");
    });

});