class Item < ApplicationRecord
  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre

  validates :image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :genre, presence: true
  validates :price, presence: true

  def taxin_price
    (price*1.1).floor
  end
end
