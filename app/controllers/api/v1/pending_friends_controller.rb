class Api::V1::PendingFriendsController < ApiController
  before_filter :authenticate_token!, only: [:show]

  def show
    current_user = authenticate_token!
    user = User.find(params[:id])
    status = !current_user.pending_friends.where(id: user.id).empty?
    render json: {
        status: status
    }
  end

end