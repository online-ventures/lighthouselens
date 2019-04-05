class AdminController < ApplicationController
  before_action -> { authorize_user 'read:items' }

  def index
  end
end
