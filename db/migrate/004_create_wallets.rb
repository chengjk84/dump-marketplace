class CreateWallets < ActiveRecord::Migration[5.0]
  def change
    create_table :wallets do |t|
      t.integer :person_id
      t.string :format

      t.timestamps
    end
  end
end
