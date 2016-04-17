require 'rails_helper'

RSpec.describe 'Update a friendship', type: :request do

  let!(:user){User.create(email: 'alice@gmail.com', password: 'password')}
  let!(:jwt){JWT.encode({'id': user.id, 'email': user.email}, Rails.application.secrets.json_web_token_secret, 'HS256')}
  let!(:otheruser){User.create(email: 'bob@gmail.com', password: 'password')}
  let!(:createrequest){
    otheruser.friend_request(user)
    user.accept_request(otheruser)
  }


  context 'Blocking friend with vaild JWT' do
    it 'returns a valid status' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      put "/api/friends/#{otheruser.id}", request_body(otheruser.id), headers
      expect(response.status).to eq 200
      expect(user.blocked_friends.first.id).to equal(otheruser.id)
    end
  end

  private

  def request_body(id)
    {
        'data':{
            'type': 'friend_request',
            'attributes': {
                'id': id,
                'action': 'block'
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