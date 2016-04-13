require 'rails_helper'

RSpec.describe 'User register through the API', type: :request do

  context 'Registration with valid credentials' do
    it 'returns a JWT' do
      post '/api/users', request_body('alice@gmail.com', 'password', 'password'), request_headers
      expect(response.status).to eq 200
      expect(response_body).to include('token')
    end
  end

  context 'Registration with bad credentials' do
    it 'returns a 422 unprocessable entity' do
      post '/api/users', request_body('alice@gmail.com', 'password', 'passwooords'), request_headers
      expect(response.status).to eq 422
    end
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
                'email': email,
                'password': password,
                'password_confirmation': password_confirmation
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