class IndexController < ApplicationController
  def index
    @top_categories = Category.find_top_categories
    @currentSID = currentSID()
    @user = currentUser()
  end
end
