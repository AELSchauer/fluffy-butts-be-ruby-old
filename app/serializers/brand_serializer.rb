class BrandSerializer < BaseSerializer
  attributes :name, :origin_country
  has_many :product_lines
  has_many :images
end