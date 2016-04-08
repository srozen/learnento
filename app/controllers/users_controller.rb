class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update, :index]
  before_action :redirect_unless_owner!, only: [:edit]

  PAGE_SIZE = 10

  def index
    @page = (params[:page] || 0).to_i

    if params[:keywords].present?
      @keywords = params[:keywords]
      user_searcher = UserSearcher.new(@keywords, current_user.id)
      @users = User.where(
                       user_searcher.where_clause,
                       user_searcher.where_args).
                    where(user_searcher.exclude_clause,
                        user_searcher.exclude_args).
                    order(user_searcher.order).
                    offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
    else
      @users = User.where.not(id: current_user.id).offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
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
