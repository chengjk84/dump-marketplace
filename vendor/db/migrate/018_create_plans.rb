class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :level
    end

    Plan.create!( name: "VIP 1", price: 50.00, level: 3)
    Plan.create!( name: "VIP 2", price: 100.00, level: 4)
    Plan.create!( name: "VIP 3", price: 200.00, level: 5)
  end
end
