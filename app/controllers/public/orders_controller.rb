class Public::OrdersController < ApplicationController
  def confirmation
  end

  def finish
  end

  def index
    @order = Order.page(params[:page])
  end

  def new
  end

  def show
  end

  def create
  end

  private

  def address_params
    params.require(:order).permit(:postal_code, :address, :name, :address, :postage, :billing_amount, :payment_method, :status)
  end
end
