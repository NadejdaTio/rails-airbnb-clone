class GamesController < ApplicationController

  before_action :find_game, only: [:show, :update, :edit, :destroy]

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @profile = @game.profile
    @reviews = OwnerReview.all.select {|review| review.profile == @profile }
    @recos = Game.all.select {|game| game.category == @game.category }
    #@order = Order.new()
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

  def search_params
    params.permit(:address, :start_date, :category)
  end
end
