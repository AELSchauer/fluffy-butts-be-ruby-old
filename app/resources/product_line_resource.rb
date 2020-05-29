class ProductLineResource < JSONAPI::Resource
  attributes :name
  has_one :brand
  has_many :products
  has_many :tags
end