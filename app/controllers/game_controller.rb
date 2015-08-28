class GameController < ApplicationController
  before_action :fetch_game, only: [:show, :edit, :update, :destroy]

  def show
    @game.get_status
  end

  def new
    @game = Game.new
  end

  def edit
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to @game
    else
      render :new
    end
  end

  def update
    @game.update game_params
    if @game.save
      redirect_to @game
    else
      render :edit
    end
  end

  def destroy
    @game.destroy
    redirect_to root_path
  end

  protected
  def fetch_game
    @game = Game.find_by short_name: params[:short_name]
    raise ActiveRecord::RecordNotFound unless @game
  end
  def game_params
    params.require(:game).permit(:name, :short_name, :start_script, :stop_script, :status_script, :icon)
  end
end
