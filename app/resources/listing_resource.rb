class ListingResource < JSONAPI::Resource
  attributes :company, :currency, :link, :listing_type, :price, :quantity
  has_many :products
end
