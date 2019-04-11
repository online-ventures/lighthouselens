module Authable
  extend ActiveSupport::Concern

  class << self
    # Check for a logged in user, ensuring their login is not expired
    # Redirects to login path if they are not logged in
    def authenticate(controller)
      user = get_user controller.session
      if user.blank? or user.expired?
        logout(controller.session) if user.present?
        controller.redirect_to url_helpers.login_path
      end
      user
    end

    # Get a user and ensure they can perform an action
    # Redirects to unauthorized path if they cannot
    def authorize(controller, permission)
      user = authenticate controller
      unless user_can?(user, permission)
        controller.redirect_to url_helpers.unauthorized_path
      end
      user
    end

    # Check if the user has the permission to do something
    def user_can?(user_or_session, permission)
      user = determine_user_from_data user_or_session
      return false if user.blank?
      user.can? permission
    end

    def determine_user_from_data(data)
      return data if data.is_a? User
      return get_user(data) if data.is_a? ActionDispatch::Request::Session
      nil
    end

    def get_user(session)
      auth_id = session[:auth_id]
      return nil if auth_id.blank?
      user = User.where(auth_id: auth_id).first
      session[:auth_id] = nil if user.blank?
      user
    end

    def logout(session)
      session[:auth_id] = nil
    end

    def url_helpers
      Rails.application.routes.url_helpers
    end
  end

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

  def load_user
    auth_id = session[:auth_id]
    return if auth_id.blank?
    @current_user = User.where(auth_id: auth_id).first
    session[:auth_id] = nil if @current_user.blank?
    @current_user
  end

  def current_user
    @current_user
  end

  class AuthenticationError < StandardError
  end

  class AuthorizationError < StandardError
  end
end
