$('.ticket_form')
    .on 'cocoon:before-insert', (e, task_to_be_added) ->
      console.log('before insert')
      task_to_be_added.fadeIn('slow')
    .on 'cocoon:after-insert', (e, added_task) ->
      console.log('after insert')
      added_task.css("background","red")
    .on 'cocoon:before-remove', (e, task_to_be_removed) ->
      console.log('before remove')
      task_to_be_removed.fadeOut('slow')
    .on 'cocoon:after-remove', (e, removed_task) ->
      console.log('after remove')
