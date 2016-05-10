class Api::V1::ConversationNotificationsController < ApiController
  before_filter :authenticate_token!, only: [:show, :index]

  def index
    current_user = authenticate_token!
    render json: {
      conversation_notifications: current_user.conversation_notifications
    }
  end

  def show
    current_user = authenticate_token!
    render json: {
        status: current_user.conversation_notifications.find_by(conversation_id: params[:id]).status
    }
  end
end