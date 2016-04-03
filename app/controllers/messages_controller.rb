class MessagesController < ApplicationController
  include ActionController::Live

  def index
    @messages = Message.all
  end

  def create
    @message = Message.create(user_id: params[:user_id], content: params[:content])
    $redis.publish 'chat_event', { 'user' => @message.user.email, 'content' => @message.content}.to_json
    render json: {}, status: 200
  end

  def new
    @message = Message.new
  end

  def sub
    response.headers["Content-Type"] = "text/event-stream"

    redis = Redis.new
    redis.subscribe(['chat_event', 'heartbeat']) do |on|
      on.message do |event, data|
        response.stream.write "event: #{event}\ndata: #{data}\n\n"
      end
    end
  rescue ClientDisconnected
    redis.quit
    logger.info "Stream Closed"
  ensure
    redis.quit
    response.stream.close
  end
end
