$(document).ready(function() {
  $('form.edit_question').bind('ajax:success', function(e, data, status, xhr) {
    question = $.parseJSON(xhr.responseText);
    $('.edit-form').replaceWith('<p>Title: ' + question.title + ' text: ' + question.body + '</p>');
    $('.question-messages').append('<p>Your question successfully updated</p>');
    $('.question-messages').append('<a href="/questions/">Back</a>');
  }).bind('ajax:error', function (e, xhr, status, error) {
    errors = $.parseJSON(xhr.responseText);
    $.each(errors, function(index, messages){
      $('.question-messages').append("<p>" + messages + "</p>");
    });
  }).bind('ajax:before', function(){
    $('.question-messages').html('');
  }); 
});