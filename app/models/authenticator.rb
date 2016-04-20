class Authenticator
  def validate_credentials!(email, password)
    user = User.find_by!(email: email)
    raise_authentication_error unless user.valid_password?(password)
    user
  end

  def validate_registration!(req)
    User.create!(email: req['data']['attributes']['email'],
                 password: req['data']['attributes']['password'],
                 password_confirmation: req['data']['attributes']['password_confirmation'])
  end

  def analyse_token_from_request(request)
    begin
      header = request.headers['Authorization']
      raise_authentication_error unless !header.nil?
      token = header.split(' ').last
      decoded_token = JWT.decode(token, Rails.application.secrets.json_web_token_secret, true)
      User.find_by!(id: decoded_token[0]['id'], email: decoded_token[0]['email'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      raise_authentication_error
    end
  end

  class AuthenticationException < StandardError; end

  class AuthorizationException < StandardError; end

  private

  def raise_authentication_error
    raise AuthenticationException, 'Bad credentials'
  end
end