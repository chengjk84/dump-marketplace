class Conversation < ApplicationRecord
  belongs_to :person
  belongs_to :business

  has_many :messages, dependent: :destroy

end
