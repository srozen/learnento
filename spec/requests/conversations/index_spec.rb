require 'rails_helper'

RSpec.describe 'Fetch all of a user conversations', type: :request do

  let!(:user){User.create(email: 'alice@gmail.com', password: 'password')}
  let!(:jwt){JWT.encode({'id': user.id, 'email': user.email}, Rails.application.secrets.json_web_token_secret, 'HS256')}
  let!(:otheruser){User.create(email: 'bob@gmail.com', password: 'password')}
  let!(:randomuser){User.create(email: 'charlie@gmail.com', password: 'password')}
  let!(:createrequest){
    otheruser.friend_request(user)
    randomuser.friend_request(user)
  }


  context 'User asks for all of his conversations with a valid JWT' do
    it 'returns a valid status and all the messages' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      put "/api/friend_requests/#{otheruser.id}", friend_request_body(otheruser.id), headers
      put "/api/friend_requests/#{randomuser.id}", friend_request_body(randomuser.id), headers

      get '/api/conversations', '', headers
      expect(response.status).to eq 200
      expect(response_body).to include('conversations')
      expect(response_body['conversations'].count).to eq 2
    end
  end

  context 'User asks for all of his conversations without a valid JWT' do
    it 'returns an unauthorized status 401' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer doge"
      put "/api/friend_requests/#{otheruser.id}", friend_request_body(otheruser.id), headers
      put "/api/friend_requests/#{randomuser.id}", friend_request_body(randomuser.id), headers

      get '/api/conversations', '', headers
      expect(response.status).to eq 401
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

  def request_headers
    {
        'HTTP_ACCEPT': 'application/vnd.learnento+json; version=1',
        'CONTENT_TYPE': 'application/vnd.learnento+json; version=1'
    }
  end

end