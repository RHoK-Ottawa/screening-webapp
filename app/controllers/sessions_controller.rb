class SessionsController < ApplicationController
  skip_before_action :authorize!

  def create
    user = User.find_or_create_from_auth(auth)
    session[:user_id] = user.id if user

    redirect_to root_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
