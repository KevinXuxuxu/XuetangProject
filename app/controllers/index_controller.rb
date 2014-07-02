class IndexController < ApplicationController
  def index
    @top_categories = Category.find_top_categories
  end
end
