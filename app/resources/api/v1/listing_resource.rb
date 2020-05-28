class Api::V1::ListingResource < JSONAPI::Resource
  attributes :currency, :link, :listing_type, :price, :quantity
  has_many :products
end
