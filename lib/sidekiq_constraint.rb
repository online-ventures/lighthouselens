class SidekiqConstraint
  def matches?(request)
    Authable.user_can? request.session, 'read:sidekiq'
  end
end
