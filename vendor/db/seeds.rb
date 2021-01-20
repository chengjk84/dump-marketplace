Person.create!( email: 'john.doe@atlantis2u.com', password: 'p4S5wd#1Ze', first_name: 'John', last_name: 'Doe' )
Transaction.create!(wallet_id: 1, description: "Top up cash to wallet", ref_no: "depo_#{SecureRandom.hex(3)}", debit: rand(499...1000), status: "success")

Person.create!( sponsor_id: 1, email: 'chengjk@gmx.com', password: 'n1ck.7aRc', first_name: 'JinKang', last_name: 'Cheng', master: true, admin: true )
Transaction.create!(wallet_id: 3, description: "Top up cash to wallet", ref_no: "depo_#{SecureRandom.hex(3)}", debit: rand(499...1000), status: "success")

wallet_id = 5

48.times do
  first_name = Faker::Name.unique.first_name
  Person.create!(
    sponsor_id: rand(1...Person.all.count),
    email: Faker::Internet.safe_email(first_name),
    password: 'password#123',
    first_name: first_name,
    last_name: Faker::Name.last_name
  )

  Transaction.create!( wallet_id: wallet_id, description: "Top up cash to wallet", ref_no: "depo_#{SecureRandom.hex(3)}", debit: rand(499...1000), status: "success" )
  wallet_id = wallet_id + 2
end

puts "Demo people created!"

50.times do
  person = Person.find(rand(3..50))
  business = person.businesses.build

  business.referrer_id = person.sponsor.id
  business.name = Faker::Company.name
  business.email = Faker::Internet.unique.email
  business.mobile = Faker::PhoneNumber.cell_phone
  business.save
end

puts "Demo businesses created!"

100.times do
  Product.create!(
    business_id: rand(1...50),
    name: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph(3),
    price: rand(15.50...99.90),
    featured: [true, false].sample,
    stock_in_hand: rand(0...100),
    shipment_peninsular: [6, 7, 8].sample,
    shipment_sabah_and_labuan: [12, 15, 18].sample,
    shipment_sarawak: [12, 15, 18].sample
  )
end

puts "Demo products created!"
