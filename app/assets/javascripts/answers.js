$(document).ready(function() {
  $('form.new_answer').bind('ajax:success', function(e, data, status, xhr) {
    answer = $.parseJSON(xhr.responseText);
    $('.answers').append('<div class="answer" id="answer_' + answer.id + '"><p>' + answer.body + '</p></div>');
    $('#answer_body').val('');
  }).bind('ajax:error', function (e, xhr, status, error) {
    errors = $.parseJSON(xhr.responseText);
    $.each(errors, function(index, messages){
      $('.answer-messages').append("<p>" + messages + "</p>");
    })
  }).bind('ajax:before', function(){
    $('.answer-messages').html('');
  }); 

});