class PagesController < ApplicationController
  rescue_from ActionView::MissingTemplate, with: :unknown_template

  def not_found
    render status: :not_found
  end

  private

  def unknown_template
    head :not_found
  end
end
