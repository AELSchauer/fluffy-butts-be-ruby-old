class Collection < ApplicationRecord
  belongs_to :product_line
  has_many :products, through: :collection_products
end
