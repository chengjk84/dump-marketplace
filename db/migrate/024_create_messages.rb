class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :conversation_id
      t.string :remark # %w{"person", "business"}
      t.text :content
      t.boolean :read, :default => false

      t.timestamps
    end
  end
end
