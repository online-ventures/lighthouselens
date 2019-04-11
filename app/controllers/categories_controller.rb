class CategoriesController < ApplicationController
  def index
    @category = Category.find params[:id]
    @items = @category.items.published.active
  end
end
