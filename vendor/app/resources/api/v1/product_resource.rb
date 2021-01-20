class Api::V1::ProductResource < JSONAPI::Resource
  attributes :name, :price, :image_01

  belongs_to :business
end