require 'rails_helper'

RSpec.describe 'User profile edition', type: :request do

  let!(:user){User.create(id: 1, email: 'alice@gmail.com', password: 'password')}
  let!(:jwt){JWT.encode({'id': user.id, 'email': user.email}, Rails.application.secrets.json_web_token_secret, 'HS256')}

  context 'User edit profile with right infos and valid token' do

  end

  context 'User edit with invalid infos' do

  end

  context 'User edit with invalid token' do

  end

  context 'User try to edit other profile' do

  end

  private

  def response_body
    JSON.parse(response.body)
  end

  def request_body(email, password, password_confirmation)
    {
        'data':{
            'type': 'user',
            'attributes': {
                'first-name': email,
                'last-name': password,
                'avatar' => {
                    'data' => Base64.encode64(File.open(resources_path('images', 'default.jpg'), 'rb').read),
                    'name' => 'default.jpg'
                }
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