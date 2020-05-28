class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :taggable, polymorphic: true

  def self.tags
    Tag.where(id: self.pluck(:tag_id))
  end
end
