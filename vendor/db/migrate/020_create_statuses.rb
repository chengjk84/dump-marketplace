class CreateStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :statuses do |t|
      t.string :name

      t.timestamps
    end

    Status.create!( name: "In Progress" )           # 1 -> c        Customer using Shopping Cart
    Status.create!( name: "Unpaid" )                # 2 -> c        Customer action Place Order(checkout). If want to combine shipment, Request Combine Shipment; Else proceed to payment and Paid.
    Status.create!( name: "Request Shipment" )      # 3 -> c - m    Customer request for combine shipment; wait for Merchant to enter new shipment value
    Status.create!( name: "Confirmed" )             # 4 -> m - c    Merchant comfirmed shipment total; wait for payment
    Status.create!( name: "Paid" )                  # 5 -> c - m    Paid, wait for shipping; wallet transaction and bank statement post as status: "pending"
    Status.create!( name: "Shipped" )               # 6 -> m - c    Shipped; Transfer prosedure start with shipped_at now as day 1
    Status.create!( name: "Completed" )             # 7 -> c        Received order / Redeem order; wallet transaction and bank statement update status: "success"
    Status.create!( name: "Returned" )              # 8 -> c - m    Returned defected product on order
    Status.create!( name: "Complain" )              # 9 -> c - m    Day 7 customer can issue complain
    Status.create!( name: "Canceled" )              # 10 -> c/m     Customer only can cancel unpaid order, merchant can
  end
end
