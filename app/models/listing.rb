class Listing < ApplicationRecord
  belongs_to :retailer
  belongs_to :listable, polymorphic: true

  def available
    sizes.any? { |size| size.available == true }
  end
end
