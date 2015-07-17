# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
   $('.vote-up, .vote-down').bind 'ajax:success', (e, data, status, xhr) ->
   
     div_vote = '#' + 'vote-' + data.votable_type.toLowerCase() + '-' + data.votable_id

     $(div_vote + " .rating").html(data.count_votes)
     $(div_vote + " .vote-up").hide()
     $(div_vote + " .vote-down").hide()
   
   $('.vote-cancel').bind 'ajax:success', (e, data, status, xhr) ->

     div_vote = '#' + 'vote-' + data.votable_type.toLowerCase() + '-' + data.votable_id

     $(div_vote + " .rating").html(data.count_votes)
     $(div_vote + " .vote-up").show()
     $(div_vote + " .vote-down").show()
