require 'rails_helper'

RSpec.describe 'Create a friend request', type: :request do

  let!(:user){User.create(email: 'alice@gmail.com', password: 'password')}
  let!(:jwt){JWT.encode({'id': user.id, 'email': user.email}, Rails.application.secrets.json_web_token_secret, 'HS256')}
  let!(:otheruser){User.create(email: 'bob@gmail.com', password: 'password')}


  context 'Send a friend request to valid user with vaild JWT' do
    it 'returns a valid status' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      post '/api/friend_requests', request_body(otheruser.id, 'Hello accept me !'), headers
      expect(response.status).to eq 200
      expect(otheruser.requested_friends.first.id).to equal(user.id)
    end
  end

  private

  def request_body(id, message)
    {
        'data':{
            'type': 'friend_request',
            'attributes': {
                'id': id,
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