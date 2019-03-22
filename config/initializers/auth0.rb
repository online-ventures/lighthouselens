Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    Rails.application.credentials.auth_client_id,
    Rails.application.credentials.auth_client_secret,
    Rails.application.credentials.auth_domain,
    'YOUR_CLIENT_SECRET',
    'YOUR_DOMAIN',
    callback_path: '/auth/oauth2/callback',
    authorize_params: {
      scope: 'openid profile'
    }
  )
end
