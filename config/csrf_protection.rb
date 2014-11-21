class CsrfProtection
  # check if _csrf_token is set in user’s session and compare it with token sent with message
  def incoming(message, request, callback)
    session_token = request.session['_csrf_token']
    message_token = message['ext'] && message['ext'].delete('csrfToken')
    # raise error if they aren't the same
    unless session_token == message_token
      message['error'] = '401::Access denied'
    end
    callback.call(message)
  end
end