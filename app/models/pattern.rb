class Pattern < ApplicationRecord
  belongs_to :brand
  has_many :products
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  def self.find_by_tag_ids(tag_ids = [])
    @description_tags = Tag.where(id: tag_ids);

    if @description_tags.length === 0
      self.none
    else
      self.joins("INNER JOIN taggings ON patterns.id = taggings.taggable_id AND taggings.taggable_type = 'Pattern'")
        .joins("INNER JOIN tags ON taggings.tag_id = tags.id")
        .where("tags.id IN (#{@description_tags.ids.join(', ')})")
    end
  end
end
