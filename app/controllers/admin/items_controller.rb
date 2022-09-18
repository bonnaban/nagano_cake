class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def index
   @items = Item.page(params[:page])
  end

   def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path
    else
      render :new
    end
   end

   private

   def item_params
     params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active, :image)
   end

end
