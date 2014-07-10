class PersonalController < ApplicationController
  before_action :set_user, only: [:index]
  def index
    if @user
      @messages = @user.messages
    end
  end

  private

  def set_user
    @user = currentUser
  end
end
