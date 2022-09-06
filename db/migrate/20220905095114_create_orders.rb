class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :postal_code,     null: false
      t.string :address,         null: false
      t.string :name,            null: false
      t.integer :postage,        null: false
      t.integer :billing_amount, null: false
      t.integer :payment_method, null: false, default: 0, limit: 1
      t.integer :status,         null: false, default: 0, limit: 1

      t.timestamps
    end
  end
end
