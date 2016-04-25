require 'rails_helper'

RSpec.describe 'Check pending_friends statuses through the api', type: :request do

  let!(:user){User.create(email: 'alice@gmail.com', password: 'password')}
  let!(:jwt){JWT.encode({'id': user.id, 'email': user.email}, Rails.application.secrets.json_web_token_secret, 'HS256')}
  let!(:puser){User.create(email: 'charlie@gmail.com', password: 'password')}
  let!(:friending){
    user.friend_request(puser, 'Hello add me pls')

  }
  let!(:otheruser){User.create(email: 'bob@gmail.com', password: 'password')}

  context 'Request an existing requested_friend with a valid JWT' do
    it 'returns true' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      get "/api/pending_friends/#{puser.id}", '', headers
      expect(response.status).to eq 200
      expect(response_body).to include('status')
      expect(response_body['status']).to eq(true)
      expect(response.headers['Content-Type']). to eq('application/vnd.learnento+json; version=1; charset=utf-8')
    end
  end

  context 'Request an non-existing requested_friend with a valid JWT' do
    it 'returns false' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      get "/api/pending_friends/#{otheruser.id}", '', headers
      expect(response.status).to eq 200
      expect(response_body).to include('status')
      expect(response_body['status']).to eq(false)
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