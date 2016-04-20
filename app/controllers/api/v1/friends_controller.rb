class Api::V1::FriendsController < ApiController
  before_filter :authenticate_token!, only: [:index, :update, :destroy]

  def index
    current_user = authenticate_token!
    friends = current_user.friends
    blocked_friends = current_user.blocked_friends
    render json: {
        friends: friends,
        blocked_friends: blocked_friends
    }
  end

  def update
    req = JSON.parse request.body.read
    current_user = authenticate_token!
    user = User.find(params[:id])
    if req['data']['attributes']['action'] == 'block'
      current_user.friends.find(user.id)
      current_user.block_friend(user)
    else
      current_user.blocked_friends.find_by!(id: user.id)
      current_user.unblock_friend(user)
    end
    render json: ''
  end

  def destroy
    current_user = authenticate_token!
    friend = User.find(params[:id])
    current_user.remove_friend(friend)
    render json: ''
  end

end