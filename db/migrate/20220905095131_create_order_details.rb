class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :price_including_tax, null: false
      t.integer :amount,              null: false
      t.integer :production_status,   null: false, default: 0, limit: 1

      t.timestamps
    end
  end
end
