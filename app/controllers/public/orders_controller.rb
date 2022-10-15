class Public::OrdersController < ApplicationController
  def confirm
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }

    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.name = current_customer.last_name + current_customer.first_name
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.postage = 800
      @order.billing_amount = @total + @order.postage
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.name = @address.name
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.postage = 800
      @order.billing_amount = @total + @order.postage
    elsif params[:order][:select_address] == "2"
      @order.name = params[:order][:name]
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.postage = 800
      @order.billing_amount = @total + @order.postage
    end
  end

  def finish
  end

  def index
    @customer = current_customer
    @order = @customer.orders
    @orders = Order.page(params[:page]).per(5)
  end

  def new
    @order = Order.new
    @customer = current_customer
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total = @order_details.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def create
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      @cart_items.each do |cart|
      order_details = OrderDetail.new
      order_details.item_id = cart.item_id
      order_details.order_id = @order.id
      # 購入が完了したらカート情報は削除するのでこちらに保存します
      order_details.amount = cart.amount
      # カート情報を削除するので item との紐付けが切れる前に保存します
      order_details.price_including_tax = cart.item.price
      order_details.save
      end
      @cart_items.destroy_all
      redirect_to orders_finish_path
      # ユーザーに関連するカートのデータ(購入したデータ)をすべて削除します(カートを空にする)
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :postage, :billing_amount, :payment_method)
  end
end
