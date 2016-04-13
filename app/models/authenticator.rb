class Authenticator
  def validate_credentials!(email, password)
    user = User.find_by!(email: email)
    raise_authentication_error unless user.valid_password?(password)
    user
  end

  class AuthenticationException < StandardError; end

  private

  def raise_authentication_error
    raise AuthenticationException, 'Bad credentials'
  end
end