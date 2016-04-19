require 'rails_helper'

RSpec.describe 'User request his friends index through the API', type: :request do

  let!(:user){User.create(email: 'alice@gmail.com', password: 'password')}
  let!(:jwt){JWT.encode({'id': user.id, 'email': user.email}, Rails.application.secrets.json_web_token_secret, 'HS256')}
  let!(:ruser){User.create(email: 'bob@gmail.com', password: 'password')}
  let!(:puser){User.create(email: 'charlie@gmail.com', password: 'password')}
  let!(:friending){
    user.friend_request(ruser)
    user.friend_request(puser)
    puser.accept_request(user)
    ruser.accept_request(user)
  }

  context 'Request with a valid JWT' do
    it 'returns all the friends and blocked friends' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      get '/api/friends', '', headers
      expect(response.status).to eq 200
      expect(response_body).to include('friends')
      expect(response_body).to include('blocked_friends')
      expect(response.headers['Content-Type']). to eq('application/vnd.learnento+json; version=1; charset=utf-8')
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

end