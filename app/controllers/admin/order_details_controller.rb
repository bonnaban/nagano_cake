class Admin::OrderDetailsController < ApplicationController
  def update
    @order_details = OrderDetail.find(params[:id])
    if @order_details.update(order_detail_params)
      if @order_details.production_status == "completed"
        @order_details.order.update(status: 3)
        redirect_to admin_order_path(@order_details.order)
      elsif @order_details.production_status == "production"
        @order_details.order.update(status: 2)
        redirect_to admin_order_path(@order_details.order)
      else
        redirect_to admin_order_path(@order_details.order)
      end
    else
     redirect_to admin_order_path(@order_details.order)
    end
  end

  private

   def order_detail_params
     params.require(:order_detail).permit(:production_status)
   end
end
