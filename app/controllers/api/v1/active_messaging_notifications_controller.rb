class Api::V1::ActiveMessagingNotificationsController < ApiController
  before_filter :authenticate_token!, only: [:index, :destroy]

  def index
    current_user = authenticate_token!
    render json: {
        number: current_user.active_messaging_notifications
    }
  end

  def destroy
    current_user = authenticate_token!
    current_user.update(active_messaging_notifications: 0)
    render json: {
        number: current_user.active_messaging_notifications
    }
  end
end