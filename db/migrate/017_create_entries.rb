class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.integer :collection_id
      t.integer :product_id

      t.timestamps
    end
  end
end
