class Api::V1::PersonResource < JSONAPI::Resource
  attributes :email, :first_name, :last_name, :avatar

  has_many :businesses

  #has_many :wallets
  #has_many :subscriptions
end