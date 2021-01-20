class Subscription < ApplicationRecord
  belongs_to :person
  belongs_to :plan
end
