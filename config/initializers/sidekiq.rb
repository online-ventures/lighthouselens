env = Rails.env.to_sym
config = Rails.application.credentials.redis[env]

redis = {
  url: "redis://#{config[:host]}:#{config[:port]}",
  namespace: config[:namespace]
}
redis[:password] = config[:password] if config[:password]

Sidekiq.configure_server do |config|
  config.redis = redis
end

Sidekiq.configure_client do |config|
  config.redis = redis
end
