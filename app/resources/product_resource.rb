class ProductResource < JSONAPI::Resource
  attributes :manufacturer_code
  has_one :product_line
  has_many :tags
  has_many :listings
end