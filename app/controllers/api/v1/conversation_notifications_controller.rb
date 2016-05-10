class Api::V1::ConversationNotificationsController < ApiController
  before_filter :authenticate_token!, only: [:show, :index, :update]

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

  def update
    current_user = authenticate_token!
    conversation_notification = current_user.conversation_notifications.find_by(conversation_id: params[:id])
    conversation_notification.update(status: false)
    render json: {
        status: conversation_notification.status
    }
  end
end