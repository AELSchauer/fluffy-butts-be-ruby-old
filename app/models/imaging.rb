class Imaging < ApplicationRecord
  belongs_to :image
  belongs_to :imagable, polymorphic: true
  validate :not_a_duplicate

  def self.images
    Image.where(id: self.pluck(:image_id))
  end

  private

  def not_a_duplicate
    if not Imaging.find_by(imagable_type: self.imagable_type, imagable_id: self.imagable_id, image_id: self.image_id).nil?
      errors.add(:id, "can't be a duplicate")
    end
  end
end
