require 'rails_helper'

RSpec.describe 'User fetch a conversation through the API', type: :request do

  let!(:user){User.create(email: 'alice@gmail.com', password: 'password')}
  let!(:jwt){JWT.encode({'id': user.id, 'email': user.email}, Rails.application.secrets.json_web_token_secret, 'HS256')}
  let!(:otheruser){User.create(email: 'bob@gmail.com', password: 'password')}
  let!(:createrequest){otheruser.friend_request(user)}


  context 'User asks for an existing conversation with a friend with a valid JWT' do
    it 'returns a valid status and all the messages' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      put "/api/friend_requests/#{otheruser.id}", friend_request_body(otheruser.id), headers
      post '/api/messages', message_request_body(user.id, otheruser.id, "Wassup bro?"), headers
      post '/api/messages', message_request_body(user.id, otheruser.id, "Wassup bro?"), headers
      post '/api/messages', message_request_body(user.id, otheruser.id, "Wassup bro?"), headers
      post '/api/messages', message_request_body(user.id, otheruser.id, "Wassup bro?"), headers

      conversation_id = user.conversation_with(otheruser).id
      get "/api/conversations/#{conversation_id}", '', headers
      expect(response.status).to eq 200
      expect(response_body).to include('messages')
      expect(response_body['messages'].count).to eq 4
    end
  end

  context 'User asks for a non existing conversation with a user with valid JWT' do
    it 'returns a forbidden 404 not found' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      get "/api/conversations/#{otheruser.id}", '', headers
      expect(response.status).to eq 404
    end
  end

  private

  def response_body
    JSON.parse(response.body)
  end

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