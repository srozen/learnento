class Api::V1::FriendRequestsController < ApiController
  before_filter :authenticate_token!, only: [:index, :create, :update, :destroy]

  # TODO : Better cases exploration

  def index
    current_user = authenticate_token!
    friend_requests = current_user.requested_friends
    pending_requests = current_user.pending_friends
    render json: {
        friend_requests: friend_requests,
        pending_requests: pending_requests
    }
  end

  def create
    req = JSON.parse request.body.read
    current_user = authenticate_token!
    user = User.find(req['data']['attributes']['id'])
    current_user.friend_request(user, req['data']['attributes']['message'])
    render json: ''
  end

  def update
    current_user = authenticate_token!
    user = User.find(params[:id])
    current_user.accept_request(user)
    render json: ''
  end

  def destroy
    current_user = authenticate_token!
    user = User.find(params[:id])
    current_user.decline_request(user)
    render json: ''
  end

end