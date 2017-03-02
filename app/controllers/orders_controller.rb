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
      @game = Game.find(order_params[:game_id])
      fail
      #price = @game.price
      #@order.days = days
      #@order.total_price = days * price
      #@order.status = "en demande"
      #@profile = Profil.all.select { |profil| profile.user_id == current_user.id }
      #@order.profile = @profile
    else
      redirect_to new_user_registration_path
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
    params.require(:order).permit(:start_date, :end_date, :game_id)
  end
end
