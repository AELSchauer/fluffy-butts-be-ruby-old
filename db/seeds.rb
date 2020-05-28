require 'json'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# brand_data = JSON.parse(File.read('db/fixtures/ALVA.json'))
brand_data = JSON.parse(File.read('db/fixtures/ALVA.json'))

brand = Brand.find_or_create_by({ name: brand_data['brand'], origin_country: brand_data['country_origin'] })

brand_data['product_lines'].each do |product_line_data|
  product_line = ProductLine.find_or_create_by({ name: product_line_data['name'], brand: brand })
  product_line_data['tags'].each do |tag_name|
    tag = Tag.find_or_create_by({ name: tag_name })
    product_line.tags << tag
  end
  product_line_data['products'].each do |product_data|
    product = Product.find_or_create_by({ manufactuerer_code: product_data['code'], product_line: product_line })
    product_data['tags'].each do |tag_name|
      tag = Tag.find_or_create_by({ name: tag_name })
      product.tags << tag
    end
    product_data['listings'].each do |listing_data|
      listing = Listing.find_or_create_by({
        currency: listing_data['currency'],
        link: listing_data['link'],
        price: listing_data['price'],
        quantity: listing_data['quantity'],
        listing_type: listing_data['type']
      })
      product.listings << listing
    end
  end
end
