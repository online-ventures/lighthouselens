module Authable
  extend ActiveSupport::Concern

  included do
    helper_method :current_user if respond_to?(:helper_method)
    if respond_to?(:rescue_from)
      rescue_from AuthenticationError, with: :authentication_error
      rescue_from AuthorizationError, with: :authorization_error
    end
  end

  private

  def user_signed_in?
    session[:auth_id].present?
  end

  def load_user
    auth_id = session[:auth_id]
    return if auth_id.blank?
    @current_user = User.where(auth_id: auth_id).first
    session[:auth_id] = nil if @current_user.blank?
    @current_user
  end

  def authenticate_user
    load_user if user_signed_in?
    logout_user if @current_user&.expired?
    return if @current_user.present?
    raise AuthenticationError
  end

  def authorize_user(permission)
    authenticate_user if @current_user.blank?
    return if permission.blank? or @current_user&.can? permission
    raise AuthorizationError
  end

  def logout_user
    session[:auth_id] = nil
    @current_user = nil
  end

  def authentication_error
    redirect_to '/auth/auth0'
  end

  def authorization_error
    redirect_to '/auth/unauthorized'
  end

  def current_user
    @current_user
  end

  class AuthenticationError < StandardError
  end

  class AuthorizationError < StandardError
  end
end
