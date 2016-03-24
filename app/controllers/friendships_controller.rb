class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:id])
    current_user.friend_request(@user)
    redirect_to @user
  end
end
