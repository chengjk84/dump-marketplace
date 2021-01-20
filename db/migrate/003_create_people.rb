class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.integer :sponsor_id
      t.integer :role_id, default: 1
      t.string :sponsor_token
      t.string :qr_code

      t.string :uuid

      t.string :password_digest

      t.string :email
      t.string :email_verification_token
      t.boolean :verified_email, null: false, default: false

      t.string :mobile
      t.string :mobile_verification_token
      t.boolean :verified_mobile, null: false, default: false

      t.string :first_name
      t.string :last_name

      t.references :gender, foreign_key: true, null: false, default: 1

      t.string :street_1
      t.string :street_2
      t.string :city
      t.string :postcode
      t.string :state
      t.string :country

      t.string :identification
      t.string :identification_photo
      t.boolean :verified_identification, null: false, default: false

      t.string :bank_name
      t.string :bank_account_no
      t.string :bank_account_name

      t.string :avatar

      t.boolean :active, null: false, default: true

      t.boolean :master, null: false, default: false
      t.boolean :admin, null: false, default: false

      t.timestamps
    end
  end
end
