Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    Rails.application.credentials.auth0_client,
    Rails.application.credentials.auth0_secret,
    Rails.application.credentials.auth0_domain,
    callback_path: '/auth/auth0/callback',
    authorize_params: {
      scope: 'openid email profile read:items',
      audience: 'lighthouselens.com'
    }
  )
end
