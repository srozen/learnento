class Api::V1::MessagesController < ApiController
  before_filter :authenticate_token!, only: [:create]

  def create
    req = JSON.parse request.body.read
    current_user = authenticate_token!
    friend = User.find(req['data']['attributes']['recipientId'])
    create_message!(current_user, friend, req['data']['attributes']['message'])

    render json: ''
  end
end
