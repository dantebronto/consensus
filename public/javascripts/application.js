$(document).ready(function(){
	num_topics = 1;
  $("#add_topic").click(function() {
	  var replicant = $('#topic_snippet').html();
    replicant = replicant.replace('###', num_topics);
    $('.add_topics').append(replicant);
    num_topics++;
  });
});

