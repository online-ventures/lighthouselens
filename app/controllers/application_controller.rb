class ApplicationController < ActionController::Base

  include Authable

  # Force ssl on all pages by default
  force_ssl if: :ssl_configured?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_raven_context

  before_action :set_categories

  private

  def set_categories
    @categories = Category.active
  end

  def ssl_configured?
    Rails.env.production?
  end

  def set_raven_context
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    return if current_user.blank?
    user = current_user
    Raven.user_context(id: user.id, name: user.name, email: user.email)
  end
end
