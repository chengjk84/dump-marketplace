class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :qr_code
      t.string :uuid

      t.integer :person_id
      t.integer :business_id

      t.string :shipment_service
      t.string :shipment_tracking_no
      t.string :shipment_checking_url

      t.decimal :subtotal, precision: 15, scale: 2, default: 0.00
      t.decimal :shipment, precision: 15, scale: 2, default: 0.00
      t.decimal :total, precision: 15, scale: 2, default: 0.00

      t.boolean :to_redeem_at_store

      t.datetime :ordered_at
      t.datetime :paid_at
      t.datetime :shipped_at
      t.datetime :completed_at
      t.datetime :returned_at
      t.datetime :complain_at

      t.integer :status_id # refer to status for value

      t.timestamps
    end
  end
end
