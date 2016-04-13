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

  class AuthenticationException < StandardError; end

  private

  def raise_authentication_error
    raise AuthenticationException, 'Bad credentials'
  end
end