class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items.all
    # カートに入ってる商品の合計金額
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
     redirect_to cart_items_path
    else
     render :index
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items.all
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    # ↓現在のユーザーのcart_itemsモデルからitem.idを参照してcart_itemというテーブルのデータを全て取得して変数に代入
    @cart_items = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if @cart_items.present?
      # ↓先ほどの変数の中のamountに今回fromに送ったcart_itemデータのamountをto_iで数値化して足す
			@cart_items.amount += params[:cart_item][:amount].to_i
			@cart_items.save
			redirect_to cart_items_path
    elsif @cart_item.save
			redirect_to cart_items_path
    end
  end

  private

   def cart_item_params
     params.require(:cart_item).permit(:item_id, :customer_id, :amount, :image)
   end
end

