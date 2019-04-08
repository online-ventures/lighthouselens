class SidekiqConstraint
  def matches?(request)
    auth_id = request.session[:auth_id]
    return false if auth_id.blank?
    user = User.where(auth_id: auth_id).first
    return false if user.blank?
    user.can? 'read:sidekiq'
  end
end
