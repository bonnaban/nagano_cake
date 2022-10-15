class Order < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  has_many :order_details

  enum payment_method:{
    credit_card:0,
    transfer:1
  }

  enum status:{
    waiting:0,
    confirming:1,
    production:2,
    preparing:3,
    shipped:4
  }

end