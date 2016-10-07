class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]
  before_action :redirect_logged_in, only: [:create, :new]

  def create
    email, password = user_params[:email], user_params[:password]
    user = User.find_by_credentials(email,password)
    if user
      login(user)
      redirect_to user_url(user)
    else
      flash[:errors] = user.errors
      redirect_to new_session_url
    end
  end

  def destroy
    logout(current_user)
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
