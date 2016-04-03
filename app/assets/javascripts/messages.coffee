# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#messaging').submit (e) ->
  e.preventDefault()
  e.stopPropagation()
  $.ajax '/messages',
    type: 'POST'
    data: {
      user_id: $("input#user_id").val(),
      content: $("input#content").val('')
    }
    error: (jqXHR, textStatus, errorThrown) ->
      console.log "Failed: " + textStatus
    success: (data, textStatus, jqXHR) ->
      console.log "Success: " + textStatus

$(document).ready ->
  source = new EventSource('/sub')
  source.addEventListener 'chat_event', (e) ->
    message = $.parseJSON(e.data)
    $('#messages').append("<li><b>#{message.user}</b> : #{message.content}</li>")