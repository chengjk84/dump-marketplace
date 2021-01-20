class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.integer :order_id
      t.integer :product_id

      t.decimal :unit_price, precision: 15, scale: 2
      t.decimal :unit_ship, precision: 15, scale: 2
      t.integer :quantity
      t.decimal :total_price, precision: 15, scale: 2, default: 0.00
      t.decimal :total_ship, precision: 15, scale: 2, default: 0.00

      t.timestamps
    end
  end
end
