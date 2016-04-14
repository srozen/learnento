class Api::V1::UsersController < ApiController
  before_filter :authenticate_token!, only: [:show]

  def create
    req = JSON.parse request.body.read
    user = create_user!(req)
    render json: {
        'token': generate_jwt(user.id, user.email)
    }, content_type: 'application/vnd.learnento+json; version=1'
  end

  def show
    user = User.find(params[:id])
    render json: user, content_type: 'application/vnd.learnento+json; version=1'
  end

end