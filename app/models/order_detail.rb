class OrderDetail < ApplicationRecord
  has_one_attached :image
  belongs_to :order
  belongs_to :item

  enum production_status:{
    impossible:0,
    waiting:1,
    production:2,
    completed:3
  }

  def sum_of_price
    item.taxin_price * amount
  end

end
