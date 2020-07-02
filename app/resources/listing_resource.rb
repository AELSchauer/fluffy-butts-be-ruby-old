class ListingResource < JSONAPI::Resource
  belongs_to :products
  belongs_to :company
  attributes :currency, :link, :price, :sizes
end
