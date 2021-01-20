class CreateGenders < ActiveRecord::Migration[5.0]
  def change
    create_table :genders do |t|
      t.string :name
      t.string :slug
    end

    Gender.create!( name: 'Not Telling', slug: 'not-telling' )
    Gender.create!( name: 'Male', slug: 'male' )
    Gender.create!( name: 'Female', slug: 'female' )
  end
end
