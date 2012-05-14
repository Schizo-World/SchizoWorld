/* Author: 

*/


jQuery(function($){
  $('#new_post').bind("ajax:beforeSend", function() {
      $('#post_body').val("Envoi en cours ...");
    }).bind("ajax:success", function(e, data, status, xhr) {
      alert();
    }).bind("ajax:error", function(x, s, e) {
      alert();
    }).bind("ajax:complete", function(x, s) {
      $('#post_body').val("");
    })
  );



});

