class Api::V1::WalletResource < JSONAPI::Resource
  belongs_to :person
  has_many :transactions
end