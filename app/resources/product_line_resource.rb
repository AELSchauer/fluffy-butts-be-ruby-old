class ProductLineResource < JSONAPI::Resource
  attributes :name, :display_order, :details
  has_one  :brand
  has_many :images
  has_many :products
  has_many :tags

  filter :name
  filters :brand, :tags
end