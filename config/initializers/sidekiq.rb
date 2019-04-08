env = Rails.env.to_sym
config = Rails.application.credentials.redis[env]

redis = {
  url: "redis://#{config[:host]}:#{config[:port]}",
  namespace: config[:namespace]
}
redis[:password] = config[:password] if config[:password]

Sidekiq.configure_server do |config|
  config.redis = redis
  Sidekiq::Status.configure_server_middleware config, expiration: 30.minutes
  Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes
end

Sidekiq.configure_client do |config|
  config.redis = redis
  Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes
end
