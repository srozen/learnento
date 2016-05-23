class Api::V1::FriendsController < ApiController
  before_filter :authenticate_token!, only: [:index, :update, :destroy, :show]

  def index
    current_user = authenticate_token!
    friends = current_user.friends
    blocked_friends = current_user.blocked_friends
    render json: {
        friends: friends,
        blocked_friends: blocked_friends
    }
  end

  def show
    current_user = authenticate_token!
    friend = User.find(params[:id])
    status = current_user.friends_with?(friend)
    render json: {
        status: status
    }
  end

  def update
    req = JSON.parse request.body.read
    current_user = authenticate_token!
    user = User.find(params[:id])
    if req['data']['attributes']['action'] == 'block'
      current_user.friends.find(user.id)
      current_user.block_friend(user)
      destroy_conversation(user.id, current_user.id)
    else
      current_user.blocked_friends.find_by!(id: user.id)
      current_user.unblock_friend(user)
      current_user.friend_request(user)
      user.accept_request(current_user)
      create_conversation(user.id, current_user.id)
    end
    render json: ''
  end

  def destroy
    current_user = authenticate_token!
    friend = User.find(params[:id])
    destroy_conversation(friend.id, current_user.id)
    current_user.remove_friend(friend)
    render json: ''
  end

  private

  def destroy_conversation(user_id, current_user_id)
      if Conversation.between(user_id, current_user_id).present?
        conv = Conversation.between(user_id, current_user_id).first
        Conversation.destroy(conv.id)
      end
  end

  def create_conversation(user_id, current_user_id)
    if !Conversation.between(user_id, current_user_id).present?
      conversation = Conversation.create!(sender_id: user_id, recipient_id: current_user_id)
      create_conversation_notifications(user_id, current_user_id, conversation.id)
    end
  end

  def create_conversation_notifications(user_id, current_user_id, conversation_id)
    ConversationNotification.create!(user_id: user_id, conversation_id: conversation_id, status: false)
    ConversationNotification.create!(user_id: current_user_id, conversation_id: conversation_id, status: false)
  end

end