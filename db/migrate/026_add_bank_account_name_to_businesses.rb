class AddBankAccountNameToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :bank_account_name, :string
  end
end
