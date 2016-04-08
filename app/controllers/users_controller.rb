class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update, :index]
  before_action :redirect_unless_owner!, only: [:edit]

  def index
    # TODO: Exclude current_user from results
    if params[:keywords].present?
      @keywords = params[:keywords]
      user_searcher = UserSearcher.new(@keywords)
      @users = User.where(
                       user_searcher.where_clause,
                       user_searcher.where_args).
          order(user_searcher.order)
    else
      @users = User.where.not(id: current_user.id).limit(10)
    end
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
