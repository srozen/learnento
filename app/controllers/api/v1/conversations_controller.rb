class Api::V1::ConversationsController < ApiController
  before_filter :authenticate_token!, only: [:show]

  def show
    current_user = authenticate_token!
    friend = User.find(params[:id])
    validate_friendship!(current_user, friend)
    messages = current_user.conversation_with(friend).messages

    render json: {
        messages: messages
    }
  end
end