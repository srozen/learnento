require 'rails_helper'

RSpec.describe 'User send a message to his friend', type: :request do

  let!(:user){User.create(email: 'alice@gmail.com', password: 'password')}
  let!(:jwt){JWT.encode({'id': user.id, 'email': user.email}, Rails.application.secrets.json_web_token_secret, 'HS256')}
  let!(:otheruser){User.create(email: 'bob@gmail.com', password: 'password')}
  let!(:createrequest){otheruser.friend_request(user)}


  context 'User sends a message to a friend' do
    it 'returns a valid status' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      put "/api/friend_requests/#{otheruser.id}", friend_request_body(otheruser.id), headers

      conv_last_update = user.conversation_with(otheruser).updated_at
      post '/api/messages', message_request_body(user.id, otheruser.id, "Wassup bro?"), headers
      expect(response.status).to eq 200
      expect(user.conversation_with(otheruser).messages.first.content).to eq 'Wassup bro?'
      expect(user.conversation_with(otheruser).messages.first.user_id).to eq user.id
      expect(user.conversation_with(otheruser).updated_at).not_to eq conv_last_update
    end
  end

  context 'User sends a message to a friend' do
    it 'updates the conversation timestamp' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      put "/api/friend_requests/#{otheruser.id}", friend_request_body(otheruser.id), headers
      conv_last_update = user.conversation_with(otheruser).updated_at
      post '/api/messages', message_request_body(user.id, otheruser.id, "Wassup bro?"), headers

      expect(user.conversation_with(otheruser).updated_at).not_to eq conv_last_update
    end
  end

  context 'User sends a message to a non-friend user' do
    it 'returns a forbidden 403 status' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      post '/api/messages', message_request_body(user.id, otheruser.id, "Wassup bro?"), headers
      expect(response.status).to eq 403
      expect(user.conversation_with(otheruser)).to eq nil
    end
  end

  context 'User sends a message without valid JWT' do
    it 'returns an unauthorized 401 status' do
      post '/api/messages', message_request_body(user.id, otheruser.id, "Wassup bro?"), headers
      expect(response.status).to eq 401
      expect(user.conversation_with(otheruser)).to eq nil
    end
  end

  private

  def friend_request_body(id)
    {
        'data':{
            'type': 'friend_request',
            'attributes': {
                'id': id
            }
        }
    }.to_json
  end

  def message_request_body(user_id, friend_id, message)
    {
        'data':{
            'type': 'message',
            'attributes': {
                'senderId': user_id,
                'recipientId': friend_id,
                'message': message
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