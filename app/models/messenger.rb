class Messenger

  def validate_save_message!(user, friend, message)
    validate_friendship!(user, friend)
    conversation = Conversation.between(user.id, friend.id).first
    message = conversation.messages.create!(user_id: user.id, content: message)
    conversation.touch(:updated_at)
    message
  end

  def validate_friendship!(user, friend)
    if !user.friends_with?(friend)
      raise_authorization_error
    end
  end

  class AuthorizationException < StandardError; end

  private

  def raise_authorization_error
    raise AuthorizationException, 'Users are not friends.'
  end
end