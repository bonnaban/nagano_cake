class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total = @order_details.inject(0) { |sum, item| sum + item.sum_of_price }
    @order.postage = 800
    @order.billing_amount = @total + @order.postage
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      if @order.status == "confirming"
        @order.order_details.update(production_status: 1)
      end
      redirect_to admin_order_path(@order)
    else
      redirect_to admin_order_path(@order)
    end
  end

  private

   def order_params
     params.require(:order).permit(:status)
   end
end
