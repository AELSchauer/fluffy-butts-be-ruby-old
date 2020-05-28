class Tag < ApplicationRecord
  has_many :taggings
  enum category: [:Product, :ProductLine]
end
