class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.string :name
      t.string :slug
    end

    List.create!( name: 'Supermarkets', slug: 'supermarkets' )
    List.create!( name: 'Apparel', slug: 'apparel' )
    List.create!( name: 'Hardware', slug: 'hardware' )
    List.create!( name: 'Electronics', slug: 'electronics' )
    List.create!( name: 'Furniture', slug: 'furniture' )
    List.create!( name: 'Security', slug: 'security' )
    List.create!( name: 'Plumbing', slug: 'plumbing' )
    List.create!( name: 'Pest Control', slug: 'pest-control' )
    List.create!( name: 'Cafes', slug: 'cafes' )
    List.create!( name: 'Restaurants', slug: 'restaurants' )
    List.create!( name: 'Hotels', slug: 'hotels' )
    List.create!( name: 'Travel Services', slug: 'travel-services' )
    List.create!( name: 'Clinics', slug: 'clinics' )
    List.create!( name: 'Bank', slug: 'banks' )
    List.create!( name: 'Salons', slug: 'salons' )
    List.create!( name: 'Car Services', slug: 'car-services' )

  end
end
