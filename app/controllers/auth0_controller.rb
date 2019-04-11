class Auth0Controller < ApplicationController
  # This stores all the user information that came from Auth0 and the IdP
  def callback
    user_data = request.env['omniauth.auth'].to_h.with_indifferent_access
    auth_id = User.get_auth_id(user_data)
    raise AuthenticationError if auth_id.blank?

    # login successful
    user = User.where(auth_id: auth_id).first_or_create
    user.set_data!(user_data)
    session[:auth_id] = user.auth_id
    redirect_to admin_path
  end

  # This handles authentication failures
  def failure
    @error = params['error_type'] || params['error']
    @message = params['error_msg'] || params['message']
  end

  # This handles authorization failures
  def unauthorized
    load_user
  end

  def logout
    session[:auth_id] = nil
    redirect_to logout_url.to_s
  end

  private

  def logout_url
    domain = Rails.application.credentials.auth0[:domain]
    client_id = Rails.application.credentials.auth0[:client]
    request_params = {
      returnTo: root_url,
      client_id: client_id
    }

    URI::HTTPS.build(host: domain, path: '/v2/logout', query: to_query(request_params))
  end

  def to_query(hash)
    hash.map { |k, v| "#{k}=#{URI.escape(v)}" unless v.nil? }.reject(&:nil?).join('&')
  end
end
