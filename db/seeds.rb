require 'json'


def upload_brand_data (brand_filename)
  tag_categories_data = JSON.parse(File.read('db/fixtures/tag_categories.json'))
  brand_data = JSON.parse(File.read(brand_filename))
  brand = Brand.find_or_create_by({ name: brand_data['brand'], origin_country: brand_data['country_origin'] })

  brand_data['patterns'].each do |pattern_data|
    pattern = Pattern.find_or_create_by({ name: pattern_data['name'], brand: brand })
    pattern_data['tags'].each do |tag_name|
      tag = Tag.find_or_create_by({ name: tag_name, category: tag_categories_data[tag_name] })
      pattern.tags << tag
    end
  end

  brand_data['product_lines'].each do |product_line_data|
    product_line = ProductLine.find_or_create_by({ name: product_line_data['name'], brand: brand })

    product_line_data['tags'].each do |tag_name|
      tag = Tag.find_or_create_by({ name: tag_name })
      product_line.tags << tag
    end

    product_line_data['products'].each do |product_data|
      pattern = Pattern.find_by({ name: product_data["pattern"], brand: brand })
      product = Product.find_or_create_by({ manufacturer_code: product_data['code'], product_line: product_line, pattern: pattern })

      if product.nil?
        print product_data
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
end

def upload_images(image_filename)
  file_data = JSON.parse(File.read(image_filename))
  file_data['directories'].each do |brand_data|
    brand = Brand.find_by(name: brand_data['name'])
    brand_data['images'].each do |image_data|
      image = Image.find_or_create_by(name: image_data['name'], link: image_data['url'])
      brand.images << image
    end

    brand_data['directories'].each do |product_line_data|
      product_line = brand.product_lines.find_by(name: product_line_data['name'])

      product_line_data['images'].each do |product_image_data|
        product = product_line.products.find_by(manufacturer_code: product_image_data['name'].sub('.jpg','').sub('.png',''))
        product_image = Image.find_or_create_by(name: product_image_data['name'], link: product_image_data['url'])
        if not product.nil?
          product.images << product_image
        else
          print product_line.name, ' ', product_image_data, "\n"
        end
      end
    end
  end
end

User.create(email: "fluffy-butts-fake@gmail.com", password: "123456", role: :admin)

upload_brand_data('db/fixtures/AlvaBaby.json')
upload_brand_data('db/fixtures/bumGenius.json')
upload_images('db/fixtures/Images.json')
