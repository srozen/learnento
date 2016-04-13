require 'rails_helper'

RSpec.describe 'User authenticate through the API', type: :request do

  let!(:user){User.create(email: 'bar@bar.foo', password: 'password')}

  context 'Authentication with valid credentials' do
    it 'returns a JWT' do
      post '/api/sessions', request_body(user.email, user.password), request_headers
      expect(response.status).to eq 200
      expect(response_body).to include('token')
    end
  end

  context 'Authentication with bad credentials' do
    it 'returns a 401 unauthorized' do
      post '/api/sessions', request_body(user.email, 'fooobaar'), request_headers
      expect(response.status).to eq 401
    end
  end

  private

  def response_body
    JSON.parse(response.body)
  end

  def request_body(email, password)
    {
        'data':{
            'type': 'user',
            'attributes': {
                'email': email,
                'password': password
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