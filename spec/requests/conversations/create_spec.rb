require 'rails_helper'

RSpec.describe 'Accept a friend creates a conversation between the users', type: :request do

  let!(:user){User.create(email: 'alice@gmail.com', password: 'password')}
  let!(:jwt){JWT.encode({'id': user.id, 'email': user.email}, Rails.application.secrets.json_web_token_secret, 'HS256')}
  let!(:otheruser){User.create(email: 'bob@gmail.com', password: 'password')}
  let!(:createrequest){otheruser.friend_request(user)}


  context 'Accept friend request to valid user with valid JWT creates a conversation' do
    it 'returns a valid status' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      put "/api/friend_requests/#{otheruser.id}", request_body(otheruser.id), headers
      expect(response.status).to eq 200
      expect(user.friends.first.id).to equal(otheruser.id)
      expect(otheruser.friends.first.id).to equal(user.id)
      expect(response.headers['Content-Type']). to eq('application/vnd.learnento+json; version=1; charset=utf-8')

      expect(Conversation.between(user.id, otheruser.id).present?).to eq true
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