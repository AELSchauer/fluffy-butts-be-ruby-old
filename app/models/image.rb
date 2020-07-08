class Image < ApplicationRecord
  has_many :imagings
  validates :name, presence: true
  validates :url, presence: true
end
