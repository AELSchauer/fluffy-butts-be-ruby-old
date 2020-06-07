class Tag < ApplicationRecord
  has_many :taggings

  enum category: {
    "TBD" => 0,
    "Color" => 1,
    "Pattern & Theme" => 2,
    "Features & Materials" => 3,
    "Product Category" => 4,
    "Product Sub-Category" => 5
  }
end
