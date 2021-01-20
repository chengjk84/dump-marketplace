class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.integer :parent_id
      t.string :name
      t.string :slug
    end

    Category.create!( name: "Women's Fashion" )
    Category.create!( name: "Home & Living" )
    Category.create!( name: "Home Appliances" )
    Category.create!( name: "Baby & Toddler" )
    Category.create!( name: "Health & Beauty" )
    Category.create!( name: "Men's Fashion" )
    Category.create!( name: "Cameras" )
    Category.create!( name: "Computers & Laptops" )
    Category.create!( name: "Mobiles & Tablets" )
    Category.create!( name: "TV, A/V & Gaming &" )
    Category.create!( name: "Wearables" )
    Category.create!( name: "Sports & Outdoors" )
    Category.create!( name: "Automotive & Media" )
    Category.create!( name: "Toys & Games" )
    Category.create!( name: "Travel & Luggage" )

  end
end
