require 'rails_helper'

RSpec.describe 'User profile edition', type: :request do

  let!(:user){User.create(id: 1, email: 'alice@gmail.com', password: 'password')}
  let!(:jwt){JWT.encode({'id': user.id, 'email': user.email}, Rails.application.secrets.json_web_token_secret, 'HS256')}

  context 'User edit profile with right infos and valid token' do
    it 'returns a valid status with a success message' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      put "/api/users/#{user.id}", request_body('Alice', 'Liddell'), headers
      expect(response.status).to eq 200
      expect(User.find(1).first_name).to eq('Alice')
      expect(response.headers['Content-Type']). to eq('application/vnd.learnento+json; version=1; charset=utf-8')
    end
  end

  context 'User edit with invalid infos' do
    it 'returns an unprocessable entity status with error message' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      put "/api/users/#{user.id}", request_body('AliceAliceAliceAliceA', 'Liddell'), headers
      expect(response.status).to eq 422
      expect(User.find(1).first_name).to eq(nil)
      expect(response_body).to include('error')
      expect(response.headers['Content-Type']). to eq('application/vnd.learnento+json; version=1; charset=utf-8')
    end
  end

  context 'User edit with invalid token' do
    it 'returns an unauthorized status' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = 'Bearer falsetokennotvalidatall000'
      put "/api/users/#{user.id}", request_body('AliceAliceAliceAliceA', 'Liddell'), headers
      expect(response.status).to eq 401
      expect(response.headers['Content-Type']). to eq('application/vnd.learnento+json; version=1; charset=utf-8')
    end
  end

  context 'User try to edit other profile' do
    it 'returns an unauthorized status' do
      headers = request_headers
      headers[:'HTTP_AUTHORIZATION'] = "Bearer #{jwt}"
      put '/api/users/2', request_body('Alice', 'Liddell'), headers
      expect(response.status).to eq 403
      expect(response.headers['Content-Type']). to eq('application/vnd.learnento+json; version=1; charset=utf-8')
    end
  end

  private

  def response_body
    JSON.parse(response.body)
  end

  def request_body(firstname, lastname)
    {
        'data':{
            'type': 'user',
            'attributes': {
                'first_name': firstname,
                'last_name': lastname,
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