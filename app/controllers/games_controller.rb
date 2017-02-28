class GamesController < ApplicationController

  before_action :find_game, only: [:show, :update, :edit, :destroy]

  def index         # GET /restaurants
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def new           # GET /restaurants/new
    @game = Game.new
  end

  def create        # POST /restaurants
    @game = Game.new(game_params)
    if @game.save!
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  def update        # PATCH/PUT /articles/:id
    @game.update(game_params)
    redirect_to game_path(@game) # Show
  end

  def edit          # GET /restaurants/:id/edit
  end

  def destroy       # DELETE /restaurants/:id
    @game.destroy
    redirect_to games_path
  end

  private

  def find_sextoy
    @game = Game.find(params[:id])
  end

  def sextoy_params
    params.require(:game).permit(:name, :description, :category, :average_duration, :min_number_players, :age_range, :price)
  end

end
