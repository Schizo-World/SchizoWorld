$(document).ready(function(){
  $('#post_body').live('keyup', function(e) {
    if (e.keyCode == 13) {
        $(this).parents('form:first').submit();
    }
  });

  $('#new_post')
    .bind("ajax:beforeSend", function(evt, xhr, settings){
      var $body = $(this).find('input[name="post[body]"]');
      // Update the text of the submit button to let the user know stuff is happening.
      // But first, store the original text of the submit button, so it can be restored when the request is finished.
      $body.data( 'origText', $(this).text() );
      $body.text( "Envoi en cours..." );
    })
    .bind("ajax:success", function(evt, data, status, xhr){
      var $form = $(this);
      // Reset fields and any validation errors, so form can be used again, but leave hidden_field values intact.
      $form.find('textarea').val("");
      $form.find('div.validation-error').empty();
      // Insert response partial into page below the form.
      $('#posts').append(xhr.responseText);
    })

    .bind('ajax:complete', function(evt, xhr, status){
      var $body = $(this).find('input[name="post[body]"]');

      // Restore the original submit button text
      $body.text( $(this).data('origText') );
    })
    .bind("ajax:error", function(evt, xhr, status, error){
      var $form = $(this),
          errors,
          errorText;

      try {
        // Populate errorText with the comment errors
        errors = $.parseJSON(xhr.responseText);
      } catch(err) {
        // If the responseText is not valid JSON (like if a 500 exception was thrown), populate errors with a generic error message.
        errors = {message: "Please reload the page and try again"};
      }

      // Build an unordered list from the list of errors
      errorText = "There were errors with the submission: \n<ul>";

      for ( error in errors ) {
        errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
      }

      errorText += "</ul>";

      // Insert error list into form
      $form.find('div.validation-error').html(errorText);
    });

});