class Api::V1::SessionsController < ApiController

  def create
    user = authenticate_user!(JSON.parse request.body.read)
    render json: {
        'token': generate_jwt(user.id, user.email)
    }
  end

end
