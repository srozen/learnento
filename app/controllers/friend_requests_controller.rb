class FriendRequestsController < ApplicationController

  def index
    @friend_requests = current_user.requested_friends
    @pending_requests = current_user.pending_friends
  end

  def update
    @user = User.find(params[:id])
    current_user.accept_request(@user)
    redirect_to friend_requests_path
  end

  def create
    @user = User.find(params[:id])
    current_user.friend_request(@user)
    redirect_to @user
  end
end
