class Api::V1::UsersController < ApiController
  before_filter :authenticate_token!, only: [:show, :index]

  PAGE_SIZE = 10

  def create
    user = create_user!(JSON.parse request.body.read)
    render json: {'token': generate_jwt(user.id, user.email)}
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    current_user = authenticate_token!
    is_owner?(current_user.id, params[:id])
    req = JSON.parse request.body.read
    current_user.update!(
        avatar: Avatar.base64_to_imagefile(req['data']['attributes']['avatar']['data'], req['data']['attributes']['avatar']['name']),
        first_name: req['data']['attributes']['first_name'],
        last_name: req['data']['attributes']['last_name']
    )
    render json: {}
  end


  def index
    current_user = authenticate_token!
    @page = (params[:page] || 0).to_i
    if params[:keywords].present?
      @keywords = params[:keywords]
      user_searcher = UserSearcher.new(@keywords, current_user.id)
      users = User.where(
          user_searcher.where_clause,
          user_searcher.where_args).
          where(user_searcher.exclude_clause,
                user_searcher.exclude_args).
          order(user_searcher.order).
          offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
    else
      users = User.where.not(id: current_user.id).offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
    end

    render json: users
  end

  private

  def is_owner?(token_id, user_id)
    if token_id != user_id.to_i
      raise Authenticator::AuthorizationException
    end
  end

end