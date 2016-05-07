class Api::V1::MessagesController < ApiController
  before_filter :authenticate_token!, only: [:create]

  def create
    req = JSON.parse request.body.read
    current_user = authenticate_token!
    friend = User.find(req['data']['attributes']['recipientId'])
    create_message!(current_user, friend, req['data']['attributes']['message'])
    friend.increment!(:active_messaging_notifications, by= 1)

    data = {
        id: friend.id,
        message: req['data']['attributes']['message']
    }
    $redis.publish "messaging#{friend.id}", data.to_json

    render json: ''
  end
end
