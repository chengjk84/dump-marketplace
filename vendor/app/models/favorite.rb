class Favorite < ApplicationRecord
  belongs_to :person
  belongs_to :product
end
