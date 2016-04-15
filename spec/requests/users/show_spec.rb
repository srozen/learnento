require 'rails_helper'

RSpec.describe 'User request other user through the API', type: :request do

  let!(:user){User.create(id: 1, email: 'alice@gmail.com', password: 'password')}
  let!(:jwt){JWT.encode({'id': user.id, 'email': user.email}, Rails.application.secrets.json_web_token_secret, 'HS256')}

  context 'Request with a valid JWT' do
    it 'returns the user requested' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      get '/api/users/1', '', headers
      expect(response.status).to eq 200
    end
  end

  context 'Request with a valid JWT but invalid user' do
    it 'returns a 401 unauthorized' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJlbWFpbCI6ImJvbG9zQGdtYWlsLmNvbSJ9.0cxTQ_O3m_7NkInlw_-fadBzToLbT9grrbKaeg5rRTI'
      get '/api/users/1',request_headers
      expect(response.status).to eq 401
    end
  end

  context 'Request with an invalid JWT' do
    it 'returns a 401 unauthorized' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = 'Bearer fesfksefkse.ef8786DZZ.dzqfdqfesf'
      get '/api/users/1',request_headers
      expect(response.status).to eq 401
    end
  end

  context 'Request without token' do
    it 'returns a 401 unauthorized' do
      get '/api/users/1',request_headers
      expect(response.status).to eq 401
    end
  end

  private

  def request_headers
    {
        'HTTP_ACCEPT': 'application/vnd.learnento+json; version=1',
        'CONTENT_TYPE': 'application/vnd.learnento+json; version=1'
    }
  end

end