class Public::CustomersController < ApplicationController
  def confirmation
  end

  def edit
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def withdrawal
  end

  def update
  end
end
