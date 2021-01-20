class CreateTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :types do |t|
      t.string :name
      t.string :slug
    end

    Type.create!( name: 'Sole Proprietorship', slug: 'sole-proprietorship' )
    Type.create!( name: 'Partnership', slug: 'partnership' )
    Type.create!( name: 'Sendirian Berhad (Sdn. Bhd.)', slug: 'sdn-bhd' )
    Type.create!( name: 'Berhad (Bhd.)', slug: 'bhd' )
    Type.create!( name: 'Non Profit', slug: 'non-profit' )

  end
end
