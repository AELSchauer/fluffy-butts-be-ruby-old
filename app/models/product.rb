class Product < ApplicationRecord
  belongs_to :pattern, optional: true
  belongs_to :product_line
  has_one  :brand, through: :product_line
  has_many :imagings, as: :imagable, dependent: :destroy
  has_many :images, through: :imagings
  has_many :listings, as: :listable, dependent: :destroy

  def self.find_by_tag_ids(tag_ids = [])
    self.where(product_line: ProductLine.find_by_tag_ids(tag_ids))
        .or(self.where(pattern: Pattern.find_by_tag_ids(tag_ids)))
  end
end