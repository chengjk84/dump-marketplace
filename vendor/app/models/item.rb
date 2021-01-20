class Item < ApplicationRecord
  belongs_to :order
  belongs_to :product


  def line_total
    unit_price * quantity
  end

  def unit_shipment
    100
  end

  def line_shipment
    unit_ship * quantity
  end
end
