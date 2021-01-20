class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.integer :person_id
      t.integer :business_id

      t.boolean :person_response
      t.boolean :business_response

      t.boolean :active, default: true

      t.timestamps
    end
  end
end
