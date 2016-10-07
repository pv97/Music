class UsersController < ApplicationController
  before_action :redirect_logged_in, only: [:create, :new]

  def create
    user = User.new(user_params)
    if user.save
      login(user)
      redirect_to user_url(user)
    else
      flash[:errors] = user.errors
      redirect_to new_user_url
    end
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
