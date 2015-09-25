class GameController < ApplicationController
  before_action :fetch_game, only: [:show, :status, :edit, :update, :destroy, :start, :stop]
  before_action :get_policy

  def show
    @game.get_status(false)
    respond_to do |format|
      format.html { @policy = GamePolicy.new(current_user, @game) }
      format.json { render json: @game.status }
    end
  end

  def status
    @game.get_status(false)
    render partial: 'application/status', locals: {game: @game}
  end

  def new
    redirect_to root_path, alert: 'Not authorized' unless @policy.create?
    @game = Game.new
  end

  def edit
    redirect_to root_path, alert: 'Not authorized' unless @policy.update?
  end

  def create
    redirect_to root_path, alert: 'Not authorized' unless @policy.create?

    @game = Game.new(game_params)

    if @game.save
      redirect_to @game
    else
      render :new
    end
  end

  def update
    redirect_to root_path, alert: 'Not authorized' unless @policy.update?

    @game.update game_params
    if @game.save
      redirect_to @game
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path, alert: 'Not authorized' unless @policy.destroy?
    @game.destroy
    redirect_to root_path
  end

  def start
    redirect_to root_path, alert: 'Not authorized' unless @policy.start?
    flash[:result] = GameManager.start_game(@game)
    redirect_to game_path(@game)
  end

  def stop
    redirect_to root_path, alert: 'Not authorized' unless @policy.stop?
    flash[:result] = GameManager.stop_game(@game)
    redirect_to game_path(@game)
  end

  protected
  def fetch_game
    @game = Game.find_by short_name: params[:short_name]
    raise ActiveRecord::RecordNotFound unless @game
  end

  def get_policy
    @policy = GamePolicy.new current_user, @game
  end

  def game_params
    params.require(:game).permit(:name, :short_name, :start_script, :stop_script, :status_script, :icon)
  end
end
