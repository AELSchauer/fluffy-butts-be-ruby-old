class ProductSerializer < BaseSerializer
  attributes :name
  has_one :product_line
  has_many :images
end