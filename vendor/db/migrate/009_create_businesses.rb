class CreateBusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :businesses do |t|
      t.integer :person_id
      t.integer :referrer_id

      t.string :name
      t.string :uuid
      t.string :qr_code

      t.string :email
      t.string :email_verification_token
      t.boolean :verified_email, null: false, default: false

      t.string :mobile
      t.string :mobile_verification_token
      t.boolean :verified_mobile, null: false, default: false

      t.string :bank_name
      t.string :bank_account_no
      t.boolean :verified_bank_account

      t.string :phone
      t.string :fax

      t.string :certificate_id
      t.string :certificate_photo
      t.boolean :verified, null: false, default: false

      t.string :gst_no
      t.string :gst_certification_photo
      t.boolean :gst_verified, null: false, default: false

      t.string :logo
      t.string :banner

      t.text :about

      t.string :street_1
      t.string :street_2
      t.string :city
      t.string :postcode
      t.string :state
      t.string :country

      t.float :lng
      t.float :lat

      t.integer :type_id
      t.integer :list_id

      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
