require 'rails_helper'

RSpec.describe 'Fetch active messaging notifications counter through the API', type: :request do

  let!(:user){User.create(email: 'alice@gmail.com', password: 'password')}
  let!(:jwt){JWT.encode({'id': user.id, 'email': user.email}, Rails.application.secrets.json_web_token_secret, 'HS256')}
  let!(:puser){User.create(email: 'charlie@gmail.com', password: 'password')}
  let!(:puserjwt){JWT.encode({'id': puser.id, 'email': puser.email}, Rails.application.secrets.json_web_token_secret, 'HS256')}

  context 'Request with a valid JWT with no notifications' do
    it 'returns the amout of active messaging notifications' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      get '/api/active_messaging_notifications', '', headers
      expect(response.status).to eq 200
      expect(response_body).to include('number')
      expect(response_body['number']).to eq 0
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