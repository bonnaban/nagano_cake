class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, except: [:index]

  def index
    @item = Item.count(:id)
    @items = Item.page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active, :image)
  end
end
