class PlayerReviewsController < ApplicationController
  before_action :find_player_review, only: [:show, :edit, :destroy, :update]
  def index
    @player_reviews = PlayerReview.all
  end

  def show
  end

  def new
    @profile = Profile.find(params[:profile_id])
    @player_review = PlayerReview.new
  end

  def create
    @player_review = PlayerReview.new(player_review_params)
    @player_review.profile = Profile.find(params[:profile_id])
    @player_review.save!
    fail
    redirect_to profile_path(:profile_id)
  end

  def edit
  end

  def update
    @player_review.update(player_review_params)
    redirect_to profile_path(:profile_id)
  end

  def destroy
    @player_review.destroy
    redirect_to pages_home_path
  end

  private

  def find_player_review
    @player_review = PlayerReview.find(params[:id])
  end

  def player_review_params
    params.require(:player_review).permit(:rating, :comment, :state, :profile_id, :order_id)
  end
end
