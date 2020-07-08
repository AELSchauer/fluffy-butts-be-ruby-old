class Product < ApplicationRecord
  belongs_to :pattern, optional: true
  belongs_to :product_line
  has_one  :brand, through: :product_line
  has_many :imagings, as: :imagable, dependent: :destroy
  has_many :images, through: :imagings
  has_many :listings, as: :listable, dependent: :destroy

  # Fix weird bug with include products.product-line timeout
  def product_line_data
    {
      id: product_line.id,
      name: product_line.name,
      display_order: product_line.display_order
    }
  end

  def available
    listings.where("sizes @> ?", '[{"available": true }]').count > 0
  end

  def self.find_by_tag_ids(tag_ids = [])
    self.where(product_line: ProductLine.find_by_tag_ids(tag_ids))
        .or(self.where(pattern: Pattern.find_by_tag_ids(tag_ids)))
  end

  def self.find_by_available(available)
    self.joins(:listings).where("listings.sizes @> ?", "[{\"available\": #{available} }]")
  end
end