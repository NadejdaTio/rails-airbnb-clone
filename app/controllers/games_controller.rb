class GamesController < ApplicationController

  before_action :find_game, only: [:show, :update, :edit, :destroy]

  def index
    search_params

    if params[:address].nil?
      owners_arr = Profile.all
    else
      owners_arr = Profile.near(params[:address], 10)
    end

    if params[:category].nil?
      @games = Game.all.select {|game| owners_arr.include?(game.profile) }
    else
      @games = Game.all.select do |game|
        owners_arr.include?(game.profile) && game.category == params[:category]
      end
    end

    @games_profile = @games.map {|game| game.profile }

    if !@games.empty?
      @owners = Profile.all.select do |profile|
        profile.latitude != nil && profile.longitude != nil && profile.user != current_user && @games_profile.include?(profile)
      end

      @hash = Gmaps4rails.build_markers(@owners) do |profile, marker|
        marker.lat profile.latitude
        marker.lng profile.longitude
        marker.infowindow render_to_string(partial: "/profiles/map_box", locals: { profile: profile })
      end
    end

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
    @profile = Profile.find(params[:profile_id])
  end

  def create

    @profile = Profile.find(params[:profile_id])
    @game = @profile.games.new(game_params)
    if @game.save!
      redirect_to profile_path(@profile)
    else
      render 'profiles/show'
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
    params.require(:game).permit(:name, :category, :description, :average_duration, :min_number_players, :max_number_players, :age_range, :price, :profile_id)
  end

  def search_params
    params.permit(:address, :start_date, :category)
  end

end
