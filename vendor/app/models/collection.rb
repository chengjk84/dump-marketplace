class Collection < ApplicationRecord
  belongs_to :person

  has_many :entries
  has_many :products, :through => :entries
end
