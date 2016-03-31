class FriendsController < ApplicationController
  def index
    @friends = current_user.friends
    @blocked_friends = current_user.blocked_friends
  end

  def update
    friend = User.find(params[:id])
    if params[:block] == 'true'
      current_user.block_friend(friend)
    else
      current_user.unblock_friend(friend)
    end
    redirect_to friends_path
  end

  def destroy
    friend = User.find(params[:id])
    current_user.remove_friend(friend)
    redirect_to friends_path
  end
end
