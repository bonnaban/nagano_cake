class OrderDetail < ApplicationRecord
  has_one_attached :image
  belongs_to :order
  belongs_to :item
  enum production_status:{
    制作不可:0,
    制作待ち:1,
    製作中:2,
    制作完了:3
  }
end
