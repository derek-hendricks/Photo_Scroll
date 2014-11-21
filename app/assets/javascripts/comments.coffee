# create new Faye client and attach it to window object
window.client = new Faye.Client('/faye')

# use addExtension method to store csrfToken in every messages ext attribute 
# this is necessary due to added csrf protection, otherwise browser won't establish connection
client.addExtension {
  outgoing: (message, callback) ->
    message.ext = message.ext || {}
    message.ext.csrfToken = $('meta[name=csrf-token]').attr('content')
    callback(message)
}
 
 # subscribe client to /comments channel 
 # when update is received, prepend new message to comments
jQuery ->
  client.subscribe '/comments', (payload) ->
    $('#comments').find('.media-list').prepend(payload.message) if payload.message
    # use prop method to set disabled attribute on input to true to prevent Post button while comment is being sent
     $('#new_comment').submit -> $(this).find("input[type='submit']").val('Sending...').prop('disabled', true)
