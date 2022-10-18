class Admin::OrderDetailsController < ApplicationController
  def update
    @order_details = OrderDetail.find(params[:id])
    # @countに初期値を与える
    @count = 0
    if @order_details.update(order_detail_params)
      # @order_detailsに紐づいているorder内のorder_detailsから一つずつデータを取り出す。
      @order_details.order.order_details.each do |order|
        if order.production_status == "completed"
          @count += 1
        end
      end
      if @order_details.production_status == "production"
          @order_details.order.update(status: 2)
      end
      # @count内の数と@order_detailsに紐づいているorder内のorder_detailsの数が一致するか確認
      if @count == @order_details.order.order_details.count
        @order_details.order.update(status: 3)
      end
      redirect_to admin_order_path(@order_details.order)
    else
     redirect_to admin_order_path(@order_details.order)
    end
  end

  private

   def order_detail_params
     params.require(:order_detail).permit(:production_status)
   end
end
