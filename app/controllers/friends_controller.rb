class FriendsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def destroy
    friend = User.find(params[:id])
    current_user.remove_friend(friend)
    redirect_to friends_path
  end
end
