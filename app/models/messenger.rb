class Messenger

  def validate_save_message!(user, friend, message)
    if !user.friends_with?(friend)
      raise_authorization_error
    else
      conversation = Conversation.between(user.id, friend.id).first
      conversation.messages.create!(user_id: user.id, content: message)
    end
  end

  class AuthorizationException < StandardError; end

  private

  def raise_authorization_error
    raise AuthorizationException, 'Users are not friends.'
  end
end