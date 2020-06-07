class Product < ApplicationRecord
  belongs_to :pattern
  belongs_to :product_line
  has_one :brand, through: :product_line
  has_many :product_listings
  has_many :listings, through: :product_listings
  has_many :imagings, as: :imagable
  has_many :images, through: :imagings

  def self.find_by_tag_ids(tag_ids = [])
    self.where(product_line: ProductLine.find_by_tag_ids(tag_ids))
        .or(self.where(pattern: Pattern.find_by_tag_ids(tag_ids)))
  end
end