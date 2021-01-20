class Api::V1::TransactionResource < JSONAPI::Resource
  belongs_to :wallet
end