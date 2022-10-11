class Public::OrdersController < ApplicationController
  def confirmation
  end

  def finish
  end

  def index
    @order = Order.page(params[:page])
  end

  def new
    @order = Order.new
    @customer = current_customer
  end

  def show
  end

  def create
  end

  private

  def address_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :postage, :billing_amount, :payment_method, :status)
  end
end
