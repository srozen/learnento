class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update, :index]
  before_action :redirect_unless_owner!, only: [:edit]

  def index
    @users = User.where.not(id: current_user.id)
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
      flash[:notice] = "Profile successfully edited!"
      redirect_to @user
    else
      redirect_to edit_user_path
    end
  end

  private

  def update_params
    params.require(:user).permit(:avatar, :first_name, :last_name)
  end
end
