require 'json'


def upload_brand_data (brand_filename)
  tag_categories_data = JSON.parse(File.read('db/fixtures/tag_categories.json'))
  brand_data = JSON.parse(File.read(brand_filename))
  brand = Brand.find_or_create_by({ name: brand_data['brand'], origin_country: brand_data['country_origin'] })
  brand.images.find_or_create_by(name: brand_data['brand'], link: "https://storage.cloud.google.com/fluffy-butts/#{brand.name.gsub(/ /,"%20")}/Logo.png")

  brand_data['patterns'].each do |pattern_data|
    pattern = brand.patterns.find_or_create_by({ name: pattern_data['name'] })
    (pattern_data['tags'] || []).each do |tag_name|
      tag = Tag.find_or_create_by({ name: tag_name, category: tag_categories_data[tag_name] })
      if !pattern.tags.include?(tag)
        pattern.tags << tag
      end
    end
  end

  brand_data['product_lines'].each do |product_line_data|
    product_line = brand.product_lines.find_or_initialize_by({ name: product_line_data['name'] })
    if !product_line.id
      product_line.details = product_line_data['details'].to_json
      product_line.save
    end

    (product_line_data['tags'] || []).each do |tag_name|
      tag = Tag.find_or_create_by({ name: tag_name })
      if !product_line.tags.include?(tag)
        product_line.tags << tag
      end
    end

    product_line_data['products'].each do |product_data|
      pattern_name = product_data["pattern"] || product_data["code"]
      pattern = Pattern.find_by({ name: pattern_name, brand: brand })
      product = product_line.products.find_or_initialize_by({ name: product_data['code'], pattern: pattern })
      if !product.id
        product.details = product_data['details'].to_json
        product.save
      end
      
      if product.nil?
        print product_data
      end

      if product.images.length === 0
        link = product_data['image_src'] || "https://storage.cloud.google.com/fluffy-butts/#{brand.name.gsub(/ /,"%20")}/#{product_line.name.gsub(/ /,"%20")}/#{product.name.gsub(/ /,"%20")}.jpg"
        product.images.find_or_create_by(name: product_data['code'], link: link)
      end

      product_data['listings'].each do |listing_data|
        product.listings.find_or_create_by({
          currency: listing_data['currency'],
          link: listing_data['link'],
          price: listing_data['price'],
          quantity: listing_data['quantity'],
          listing_type: listing_data['type']
        })
      end
    end
  end
end


User.create(email: "fluffy-butts-fake@gmail.com", password: "123456", role: :admin)

upload_brand_data('db/fixtures/AlvaBaby.json')
upload_brand_data('db/fixtures/Bambino Mio.json')
upload_brand_data('db/fixtures/Blueberry.json')
upload_brand_data('db/fixtures/bumGenius.json')
upload_brand_data('db/fixtures/GroVia.json')
upload_brand_data('db/fixtures/Thirsties.json')
