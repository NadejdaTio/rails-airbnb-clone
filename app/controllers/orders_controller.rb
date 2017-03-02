require 'date'

class OrdersController < ApplicationController
  before_action :find_order, only: [:show, :edit, :update]

  def index
    @orders = Order.all
  end

  def new
    if current_user
      @order = Order.new
      @order.start_date = DateTime.parse(params[:start_date])
      @order.end_date = DateTime.parse(params[:end_date])
      days = @order.end_date.mjd - @order.start_date.mjd
      @order.days = days
      @game = Game.find(order_params[:game_id])
      @order.game = @game

      price = @game.price
      @order.total_price = days * price
      @order.status = ""
      @profile = Profile.all.select { |profile| profile.id == params[:profile_id].to_i }.first
      @order.profile = @profile

      #availability
      arr_dates_of_location = []

      Order.all.each do |order|
        if order.game_id == @game.id
          (order.start_date..order.end_date).each do |date|
            arr_dates_of_location << date
          end
        end
      end
        if arr_dates_of_location.include?(@order.start_date) == true || arr_dates_of_location.include?(@order.end_date) == true
          redirect_to game_path(@game)
        else
          @order.status = "Demande envoyée"
          @order.save!
          redirect_to profile_path(current_user.id)
        end
    else
      redirect_to new_user_session_path
    end
  end

  def show
  end

  def create
    @order = Order.new(order_params)
    if @order.save!
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @order.update(order_params)
    redirect_to order_path(@order)
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end

  def order_params
    # params.require(:order).permit(:start_date, :end_date)
    params.permit(:start_date, :end_date, :game_id, :profile_id)
  end
end
