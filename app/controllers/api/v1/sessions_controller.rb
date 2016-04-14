class Api::V1::SessionsController < ApiController

  def create
    req = JSON.parse request.body.read
    user = authenticate_user!(req)
    render json: {
        'token': generate_jwt(user.id, user.email)
    }, content_type: 'application/vnd.learnento+json; version=1'
  end

end
