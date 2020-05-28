class Product < ApplicationRecord
  belongs_to :product_line
  has_many :product_listings
  has_many :listings, through: :product_listings
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  def self.find_by_tag_ids(tag_ids = [])
    @product_tags = Tag.where(id: tag_ids);

    if @product_tags.length === 0
      self.where(product_line: ProductLine.find_by_tag_ids(tag_ids))
    else
      self.where(product_line: ProductLine.find_by_tag_ids(tag_ids))
        .joins("INNER JOIN taggings ON products.id = taggings.taggable_id AND taggings.taggable_type = 'Product'")
        .joins("INNER JOIN tags ON taggings.tag_id = tags.id")
        .where("tags.id IN (#{tag_ids.join(', ')})")
    end
  end
end