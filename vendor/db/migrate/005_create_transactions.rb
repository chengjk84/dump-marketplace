class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :wallet_id, foreign_key: true
      t.string :description
      t.string :ref_no
      t.decimal :debit, precision: 15, scale: 2
      t.decimal :credit, precision: 15, scale: 2
      t.string :status

      t.timestamps
    end
  end
end
