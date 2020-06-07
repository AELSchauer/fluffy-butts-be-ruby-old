class Brand < ApplicationRecord
  has_many :patterns
  has_many :product_lines
  has_many :products, through: :product_lines
  has_many :imagings, as: :imagable
  has_many :images, through: :imagings
end
