class ListingResource < JSONAPI::Resource
  belongs_to :products
  belongs_to :retailer
  attributes :currency, :url, :price, :sizes
end
