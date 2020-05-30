class Image < ApplicationRecord
  has_many :imagings
  validates :name, presence: true
  validates :link, presence: true
end
