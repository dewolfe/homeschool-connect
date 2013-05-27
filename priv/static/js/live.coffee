listen_for_events=(timestamp)->
  $.ajax "/root/greetings/pull"+timestamp,
    success: (data,code,xhr)->
      i=0
      while i< data.greetins.length
        msg=data.greetings[i].greetings_text
        $("#greetings_list").append "<li>"+msg
        i++

      listen_for_events data.timestamp

  $(document).ready ->
    listen_for_events({{ timestamp }})