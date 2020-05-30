class ProductResource < JSONAPI::Resource
  attributes :manufacturer_code
  has_one :product_line
  has_one :brand
  has_many :images
  has_many :listings
  has_many :tags

  filters :id, :name, :tags, :product_line, :brand
end