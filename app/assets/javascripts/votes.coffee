

$ ->
   $('.vote-up, .vote-down').bind 'ajax:success', (e, data, status, xhr) ->
   
     div_vote = '#' + 'vote-' + data.votable_type.toLowerCase() + '-' + data.votable_id

     $(div_vote + " .rating").html(data.count_votes)
     $(div_vote + " .vote-up").hide()
     $(div_vote + " .vote-down").hide()
   
   $('.vote-cancel').bind 'ajax:success', (e, data, status, xhr) ->

     div_vote = '#' + 'vote-' + data.votable_type.toLowerCase() + '-' + data.votable_id
<<<<<<< HEAD

     $(div_vote + " .rating").html(data.count_votes)
     $(div_vote + " .vote-up").show()
     $(div_vote + " .vote-down").show()
=======
>>>>>>> lesson-10

     $(div_vote + " .rating").html(data.count_votes)
     $(div_vote + " .vote-up").show()
     $(div_vote + " .vote-down").show()
