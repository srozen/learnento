require 'rails_helper'

RSpec.describe 'Remove a friend', type: :request do

  let!(:user){User.create(email: 'alice@gmail.com', password: 'password')}
  let!(:jwt){JWT.encode({'id': user.id, 'email': user.email}, Rails.application.secrets.json_web_token_secret, 'HS256')}
  let!(:otheruser){User.create(email: 'bob@gmail.com', password: 'password')}
  let!(:createrequest){
    otheruser.friend_request(user)
    user.accept_request(otheruser)
  }


  context 'Decline a friend request to valid user with vaild JWT' do
    it 'returns a valid status' do
      expect(user.friends).to_not be_empty
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      delete "/api/friends/#{otheruser.id}", request_body(otheruser.id), headers
      expect(response.status).to eq 200
      expect(user.friends).to be_empty
      expect(otheruser.friends).to be_empty
      expect(response.headers['Content-Type']). to eq('application/vnd.learnento+json; version=1; charset=utf-8')
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