class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.integer :person_id
      t.integer :product_id

      t.timestamps
    end
  end
end
