class PersonalController < ApplicationController
  before_action :set_user, only: [:index]
  def index
    if @user
      @messages = @user.find_all_active_messages
    end
  end

  private

  def set_user
    @user = currentUser
  end
end
