class GamePolicy < ApplicationPolicy
  attr_reader :user, :game

  def initialize(user, game)
    @user = user
    @game = game
  end

  def start?
    return false unless user
    return true if user.admin
    auth = Authorization.find_by(user: @user, game: @game)
    return false unless auth
    auth.can_start
  end

  def stop?
    return false unless user
    return true if user.admin
    auth = Authorization.find_by(user: @user, game: @game)
    return false unless auth
    auth.can_stop
  end

  def create?
    user && user.admin
  end
  def update?
    user && user.admin
  end
  def destroy?
    user && user.admin
  end
end
