class Public::AddressesController < ApplicationController
  def edit
    @address = Address.find(params[:id])
  end

  def index
    @address = Address.new
    @address1 = Address.page(params[:page])
  end

  def create
     @address = Address.new(address_params)
     @address1 = Address.page(params[:page])
     @address.customer_id = current_customer.id
     if @address.save
       redirect_to addresses_path
     else
       render :index
     end
  end

  def update
    @address = Address.find(params[:id])
    @address.customer_id = current_customer.id
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
