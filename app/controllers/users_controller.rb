class UsersController < ApplicationController
  def login
  end

  def do_login
    username = params[:username]
    password = params[:password]

    user = User.get_user(username, password)
    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      session[:user_id] = nil
      flash[:login] = "Invalid credentials"
      redirect_to login_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
end
