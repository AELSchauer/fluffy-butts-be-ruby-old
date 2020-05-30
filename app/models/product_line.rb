class ProductLine < ApplicationRecord
  belongs_to :brand
  has_many :products
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_many :imagings, as: :imagable
  has_many :images, through: :imagings

  def self.find_by_tag_ids(tag_ids = [])
    @feature_tags = Tag.where(id: tag_ids);

    if @feature_tags.length === 0
      self.none
    else
      self.joins("INNER JOIN taggings ON product_lines.id = taggings.taggable_id AND taggings.taggable_type = 'ProductLine'")
        .joins("INNER JOIN tags ON taggings.tag_id = tags.id")
        .where("tags.id IN (#{@feature_tags.ids.join(', ')})")
    end
  end
end