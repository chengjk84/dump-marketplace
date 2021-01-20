class CreateJournals < ActiveRecord::Migration[5.0]
  def change
    create_table :journals do |t|
      t.string :name              # Account Name
      t.string :remark            # Source of record
      t.string :ref_no            # Transaction & Statement ref_no
      t.decimal :debitt, precision: 15, scale: 2
      t.decimal :credit, precision: 15, scale: 2

      t.timestamps
    end
  end
end
