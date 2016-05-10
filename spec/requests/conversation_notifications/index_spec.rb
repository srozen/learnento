require 'rails_helper'

RSpec.describe 'Fetch all the conversations notifications of a user', type: :request do

  let!(:user){User.create(email: 'alice@gmail.com', password: 'password')}
  let!(:jwt){JWT.encode({'id': user.id, 'email': user.email}, Rails.application.secrets.json_web_token_secret, 'HS256')}
  let!(:otheruser){User.create(email: 'bob@gmail.com', password: 'password')}
  let!(:charlie){User.create(email: 'charlie@gmail.com', password: 'password')}
  let!(:createrequest){
    otheruser.friend_request(user)
    charlie.friend_request(user)
  }

  context 'Request with a valid JWT for user with two conversations' do

    before(:each) do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      put "/api/friend_requests/#{otheruser.id}", request_body(otheruser.id), headers
      put "/api/friend_requests/#{charlie.id}", request_body(charlie.id), headers

      get '/api/conversation_notifications', '', headers
    end

    it 'returns a valid 200 status' do
      expect(response.status).to eq 200
      expect(response.headers['Content-Type']). to eq('application/vnd.learnento+json; version=1; charset=utf-8')
    end

    it 'includes 2 notifications item' do
      expect(response_body).to include('conversation_notifications')
      expect(response_body['conversation_notifications'].count).to eq 2
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

end