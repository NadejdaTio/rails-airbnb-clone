class OrdersController < ApplicationController
  before_action :find_order, only: [:show, :edit, :update]

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
    # days = order_params[:end_date] - order_params[:start_date]
    # @game = Game.find(order_params[:game_id])
    # price = @game.price
    # @order.days = days
    # @order.total_price = days * price
    # @order.status = "requested"
    # @profile = Profil.all.select { |profil| profile.user_id == current_user.id }
    # @order.profile = @profile
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
    params.require(:order).permit(:start_date, :end_date, :status, :game_id, :profile_id)
  end
end
