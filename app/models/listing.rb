class Listing < ApplicationRecord
  has_many :product_listings
  has_one :products, through: :product_listings
  enum listing_type: [:single, :set, :bulk]
end
