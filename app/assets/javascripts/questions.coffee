# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.edit-question-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    question_id = $(this).data('questionId')
    $('form#edit-question-' + question_id).show()


  PrivatePub.subscribe '/questions', (data, channel) ->
    question = $.parseJSON(data['question'])
    $('.questions').append(
      '<hr>' +
      '<br>' +
      '<p>' + question.title + '</p>' +
      '<p>' + question.body + '</p>' +
      '<a href="/questions/' + question.id + '">' + 'View answers' + '</a>'
      )
