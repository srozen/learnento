class Api::V1::FriendsController < ApiController
  before_filter :authenticate_token!, only: [:index]

  # TODO: Better cases exploration

  def index
    current_user = authenticate_token!
    friends = current_user.friends
    blocked_friends = current_user.blocked_friends
    render json: {
        friends: friends,
        blocked_friends: blocked_friends
    }, content_type: 'application/vnd.learnento+json; version=1'
  end

  def update
    req = JSON.parse request.body.read
    current_user = authenticate_token!
    friend = User.find(params[:id])
    if req['data']['attributes']['action'] == 'block'
      current_user.block_friend(friend)
    else
      current_user.unblock_friend(friend)
    end
    render json: '', content_type: 'application/vnd.learnento+json; version=1'
  end

  def destroy
    req = JSON.parse request.body.read
    current_user = authenticate_token!
    friend = User.find(params[:id])
    current_user.remove_friend(friend)
    render json: '', content_type: 'application/vnd.learnento+json; version=1'
  end

end