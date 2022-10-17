class Order < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  has_many :order_details

  validates :name, presence: true
  validates :address, presence: true
  validates :postal_code, presence: true

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