class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  def index
    @games = Game.all
  end

  protected

  helper_method :current_user
  def current_user
    @current_user ||= User.find session[:user_id] rescue nil
  end
end
