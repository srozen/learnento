class Api::V1::UsersController < ApiController
  def create
    req = JSON.parse request.body.read
    user = create_user!(req)
    render json: {
        'token': generate_jwt(user.id, user.email)
    }, content_type: 'application/vnd.learnento+json; version=1'
  end
end