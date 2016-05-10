require 'rails_helper'

RSpec.describe 'Delete a friend deletes associated conversation between the users', type: :request do

  let!(:user){User.create(email: 'alice@gmail.com', password: 'password')}
  let!(:jwt){JWT.encode({'id': user.id, 'email': user.email}, Rails.application.secrets.json_web_token_secret, 'HS256')}
  let!(:otheruser){User.create(email: 'bob@gmail.com', password: 'password')}
  let!(:createrequest){otheruser.friend_request(user)}

  context 'Delete friendship  with valid JWT also deletes the conversation' do

    before(:each) do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      put "/api/friend_requests/#{otheruser.id}", request_body(otheruser.id), headers
      expect(Conversation.between(user.id, otheruser.id).present?).to eq true
      expect(user.conversation_notifications).not_to be_empty
      delete "/api/friends/#{otheruser.id}", request_body(otheruser.id), headers
    end

    it 'removes the associated conversation' do
      expect(Conversation.between(user.id, otheruser.id).present?).to eq false
    end

    it 'removes the associated ConversationNotifications' do
      expect(user.conversation_notifications).to be_empty
      expect(otheruser.conversation_notifications).to be_empty
    end
  end

  private

  def request_body(id)
    {
        'data':{
            'type': 'friend_request',
            'attributes': {
                'id': id
            }
        }
    }.to_json
  end

  def request_headers
    {
        'HTTP_ACCEPT': 'application/vnd.learnento+json; version=1',
        'CONTENT_TYPE': 'application/vnd.learnento+json; version=1'
    }
  end

end