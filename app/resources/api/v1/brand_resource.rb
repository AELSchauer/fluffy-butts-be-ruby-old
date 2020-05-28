class Api::V1::BrandResource < JSONAPI::Resource
  attributes :name, :origin_country
  has_many :product_lines
end