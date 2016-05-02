class Api::V1::FriendRequestsController < ApiController
  before_filter :authenticate_token!, only: [:index, :create, :update, :destroy, :show]

  def index
    current_user = authenticate_token!
    friend_requests = current_user.requested_friends
    pending_requests = current_user.pending_friends
    render json: {
        friend_requests: friend_requests,
        pending_requests: pending_requests
    }
  end

  def show
    current_user = authenticate_token!
    user = User.find(params[:id])
    message = current_user.friendships.find_by(friend_id: user.id).message
    render json: {
        message: message
    }
  end

  def create
    req = JSON.parse request.body.read
    current_user = authenticate_token!
    user = User.find(req['data']['attributes']['id'])
    current_user.friend_request(user, req['data']['attributes']['message'])

    data = {
      id: user.id,
      message: current_user.first_name + ' vous a envoyé une demande d\'amitié ! '
    }
    $redis.publish "notify#{user.id}", data.to_json

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

  private



end