class Api::V1::BusinessResource < JSONAPI::Resource
  attributes :name

  has_many :products
end
