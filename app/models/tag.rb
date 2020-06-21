class Tag < ApplicationRecord
  has_many :taggings

  enum category: {
    "TBD" => 0,
    "Color" => 1,
    "Pattern & Theme" => 2,
    "Features" => 3,
    "Age" => 4,
    "Product Type" => 5,
    "Product Series" => 6
  }
end
