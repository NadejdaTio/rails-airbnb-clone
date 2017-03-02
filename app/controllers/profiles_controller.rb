class ProfilesController < ApplicationController
  before_action :find_profile, only: [:show, :edit, :destroy, :update]

  def owner?(profile)
    @games_profile = Game.all.map {|game| game.profile }
    @games_profile.include?(profile) ? true : false
  end

  def index
    @profiles = Profile.all
    @owners = @profiles.select {|profile| owner?(profile)}

    @hash = Gmaps4rails.build_markers(@profiles) do |profile, marker|
      marker.lat profile.latitude
      marker.lng profile.longitude
      marker.infowindow render_to_string(partial: "/profiles/map_box", locals: { profile: profile })
    end
  end

  def show
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = User.find(current_user)
    if @profile.save!
      redirect_to profile_path(@profile)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @profile.update(profile_params)
    redirect_to profile_path(@profile)
  end

  def destroy
    @profile.destroy
    redirect_to pages_home_path
  end

  private

  def find_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :address, :phone_number, :photo)
  end
end
