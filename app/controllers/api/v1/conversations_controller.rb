class Api::V1::ConversationsController < ApiController
  before_filter :authenticate_token!
end