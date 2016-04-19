class ApiController < ApplicationController
  protect_from_forgery with: :null_session
  include ActiveSupport::Rescuable
  rescue_from Authenticator::AuthenticationException, with: :render_unauthorized
  rescue_from ActiveRecord::RecordNotFound, with: :render_unauthorized
  rescue_from ActiveRecord::RecordInvalid do |exception| render_unprocessable(exception.to_s) end

  def authenticate_token!
    authenticator = Authenticator.new
    current_user = authenticator.analyse_token_from_request(request)
  end

  def authenticate_user!(req)
    authenticator = Authenticator.new
    authenticator.validate_credentials!(req['data']['attributes']['email'], req['data']['attributes']['password'])
  end

  def create_user!(req)
    authenticator = Authenticator.new
    authenticator.validate_registration!(req)
  end

  def generate_jwt(id, email)
    JWT.encode({'id': id, 'email': email}, Rails.application.secrets.json_web_token_secret, 'HS256')
  end

  private

  def render_unauthorized
    render json: {}, status: :unauthorized, content_type: 'application/vnd.learnento+json; version=1'
  end

  def render_unprocessable(message = nil)
    render json: {'error': message}, status: :unprocessable_entity, content_type: 'application/vnd.learnento+json; version=1'
  end
end