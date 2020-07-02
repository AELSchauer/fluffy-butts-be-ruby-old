class Listing < ApplicationRecord
  belongs_to :company
  belongs_to :listable, polymorphic: true
end
