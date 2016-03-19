class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(update_params)
      redirect_to user_path
    else
      redirect_to edit_user_path
    end
  end

  private

  def update_params
    params.require(:user).permit(:avatar, :first_name, :last_name)
  end
end
