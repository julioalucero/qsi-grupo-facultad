flash_message = '<div class="alert alert-success"><a class="close" data-dismiss="alert"> ×</a><div id="flash_notice">Tags actualizados.</div></div>'
$('#flash_messages').html(flash_message)
$('#flash_messages').fadeOut(4000, 'linear')
setTimeout (->
  $('#flash_messages').html('')
  $('#flash_messages').fadeIn()
  return
), 4500
