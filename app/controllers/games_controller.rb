class GamesController < ApplicationController

  before_action :find_game, only: [:show, :update, :edit, :destroy]

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save!
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  def update
    @game.update(game_params)
    redirect_to game_path(@game) # Show
  end

  def edit
  end

  def destroy
    @game.destroy
    redirect_to games_path
  end

  private

  def find_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name, :description, :category, :average_duration, :min_number_players, :age_range, :price)
  end

end
