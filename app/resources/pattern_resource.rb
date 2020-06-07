class PatternResource < JSONAPI::Resource
  attributes :name
  has_many :products
  has_many :tags

  filters :name
  filters :brand, :tags
end