class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :business_id
      t.integer :category_id

      t.string :name

      t.string :qr_code
      t.string :uuid

      t.text :description

      t.decimal :price, precision: 15, scale: 2
      t.decimal :promotion, precision: 15, scale: 2

      t.integer :stock_in_hand, default: 0

      t.decimal :shipment_peninsular, precision: 15, scale: 2, default: 0.00
      t.decimal :shipment_sabah_and_labuan, precision: 15, scale: 2, default: 0.00
      t.decimal :shipment_sarawak, precision: 15, scale: 2, default: 0.00

      t.string :image_01
      t.string :image_02
      t.string :image_03
      t.string :image_04
      t.string :image_05

      t.boolean :featured

      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
