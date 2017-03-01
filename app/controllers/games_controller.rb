class GamesController < ApplicationController

  before_action :find_game, only: [:show, :update, :edit, :destroy]

  def index
    search_params
    #if current_user
    owners_arr = Profile.near(params[:address], 10)
    #@owner = owners_arr.first #Profile.find_by(user: current_user)

    @games = Game.all.select do |game|
      owners_arr.include?(game.profile) && game.category == params[:category]
    end

    @games_profile = @games.map do |game|
      game.profile
    end

    if !@games.empty?
      #@owner_coordinates = { lat: @owner.latitude, lng: @owner.longitude }
      @owners = Profile.all.select do |profile|
        profile.latitude != nil && profile.longitude != nil && profile.user != current_user && @games_profile.include?(profile)
      end

      @hash = Gmaps4rails.build_markers(@owners) do |profile, marker|
        marker.lat profile.latitude
        marker.lng profile.longitude
        marker.infowindow render_to_string(partial: "/profiles/map_box", locals: { profile: profile })
      end
    end

    # else
    #   redirect_to new_user_session_path
    # end


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
