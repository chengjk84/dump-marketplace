class CreateBanks < ActiveRecord::Migration[5.0]
  def change
    create_table :banks do |t|
      t.integer :business_id, foreign_key: true

      t.timestamps
    end
  end
end
