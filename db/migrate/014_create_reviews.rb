class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :product
      t.integer :person
      t.text :body

      t.timestamps
    end
  end
end
