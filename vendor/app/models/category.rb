class Category < ApplicationRecord
  belongs_to :parent, optional: true

  has_many :products
end
