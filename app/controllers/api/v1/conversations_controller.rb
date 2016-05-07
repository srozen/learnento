class Api::V1::ConversationsController < ApiController
  before_filter :authenticate_token!, only: [:show, :index]

  def show
    current_user = authenticate_token!
    conversation = Conversation.find_by!(id: params[:id])
    friend = User.find_by!(id: retrieve_related(conversation, current_user.id))
    validate_friendship!(current_user, friend)
    messages = conversation.messages

    render json: {
        messages: messages
    }
  end

  def index
    current_user = authenticate_token!
    conversations = Conversation.involving(current_user)
    render json: {
        conversations: conversations
    }
  end

  private

  def retrieve_related(conv, id)
    id == conv.sender_id ? conv.recipient_id : conv.sender_id
  end
end