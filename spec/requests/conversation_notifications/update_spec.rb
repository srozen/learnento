require 'rails_helper'

RSpec.describe 'Fetch a single conversation notification of a user', type: :request do

  let!(:user){User.create(email: 'alice@gmail.com', password: 'password')}
  let!(:jwt){JWT.encode({'id': user.id, 'email': user.email}, Rails.application.secrets.json_web_token_secret, 'HS256')}
  let!(:otheruser){User.create(email: 'bob@gmail.com', password: 'password')}
  let!(:otherjwt){JWT.encode({'id': otheruser.id, 'email': otheruser.email}, Rails.application.secrets.json_web_token_secret, 'HS256')}
  let!(:charlie){User.create(email: 'charlie@gmail.com', password: 'password')}
  let!(:createrequest){
    otheruser.friend_request(user)
    charlie.friend_request(user)
  }


  context 'Request a conversation_notification after receiving a message and reading it' do
    before(:each) do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      put "/api/friend_requests/#{otheruser.id}", request_body(otheruser.id), headers

      pheaders = request_headers
      pheaders[:'HTTP_AUTHORIZATION'] = "Bearer #{otherjwt}"
      post '/api/messages', message_request_body(otheruser.id, user.id, "Wassup bro?"), pheaders


      conversation = user.conversation_with(otheruser)
      get "/api/conversation_notifications/#{conversation.id}", '', headers
      expect(response_body['status']).to eq true
      put "/api/conversation_notifications/#{conversation.id}", '', headers
    end

    it 'returns a 200 valid status' do
      expect(response.status).to eq 200
      expect(response.headers['Content-Type']). to eq('application/vnd.learnento+json; version=1; charset=utf-8')
    end

    it 'returns a FALSE response status, the message has been read' do
      expect(response_body).to include('status')
      expect(response_body['status']).to eq false
    end
  end

  private

  def response_body
    JSON.parse(response.body)
  end

  def request_headers
    {
        'HTTP_ACCEPT': 'application/vnd.learnento+json; version=1',
        'CONTENT_TYPE': 'application/vnd.learnento+json; version=1'
    }
  end

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

  def message_request_body(user_id, friend_id, message)
    {
        'data':{
            'type': 'message',
            'attributes': {
                'user_id': user_id,
                'recipientId': friend_id,
                'content': message
            }
        }
    }.to_json
  end

end