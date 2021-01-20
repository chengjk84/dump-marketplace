class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.integer :person_id
      t.integer :plan_id
      t.string :expired_at

      t.timestamps
    end
  end
end
