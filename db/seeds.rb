require "json"


def upload_retailers 
  retailers_data = JSON.parse(File.read("db/fixtures/retailers.json"))
  retailers_data.each do |retailer_data|
    retailer = Retailer.find_or_initialize_by(name: retailer_data["name"])
    if !retailer.id
      retailer.shipping = retailer_data["shipping"]
      retailer.save
    end
  end
end


tag_categories_data = JSON.parse(File.read("db/fixtures/tag_categories.json"))

def upload_brand_data (brand_filename)
  brand_data = JSON.parse(File.read(brand_filename))
  brand = Brand.find_or_create_by({ name: brand_data["brand"], origin_country: brand_data["country_origin"] })
  brand.images.find_or_create_by(name: brand_data["brand"], url: "https://storage.cloud.google.com/fluffy-butts/#{brand.name.gsub(/ /,"%20")}/Logo.png")
  
  brand_data["patterns"].each do |pattern_data|
    pattern = brand.patterns.find_or_create_by({ name: pattern_data["name"] })
    (pattern_data["tags"] || []).each do |tag_name|
      tag = Tag.find_or_create_by({ name: tag_name })
      if !pattern.tags.include?(tag)
        pattern.tags << tag
      end
    end
  end
  
  brand_data["product_lines"].each do |product_line_data|
    product_line = brand.product_lines.find_or_initialize_by({ name: product_line_data["name"], display_order: product_line_data["sort_order"] })
    if !product_line.id
      product_line.details = product_line_data["details"]
      product_line.save
    end
    
    (product_line_data["tags"] || []).each do |tag_name|
      tag = Tag.find_or_create_by({ name: tag_name })
      if !product_line.tags.include?(tag)
        product_line.tags << tag
      end
    end
    
    product_line_data["products"].each do |product_data|
      if product_data["pattern"]
        pattern = Pattern.find_by({ name: product_data["pattern"], brand: brand })
        product = product_line.products.find_or_initialize_by({ name: product_data["name"], pattern: pattern })
      else
        product = product_line.products.find_or_initialize_by({ name: product_data["name"] })
      end
      
      if !product.id
        product.details = product_data["details"].to_json
        product.save
      end
      
      if product.nil?
        puts brand.name
        puts product_line.id
      end
      
      if product.images.length === 0
        url = "https://fluffy-butts-product-images.s3.us-east-2.amazonaws.com/#{brand.name.gsub(/ /,"+")}/#{product_line.name.gsub(/ /,"+")}/Products/#{product.name.gsub(/ /,"+")}.jpg"
        image = product.images.find_or_create_by(name: product_data["name"], url: url)
        if product_data["default"]
          product_line.images << image
        end
      end
      
      product_data["listings"].each do |listing_data|
        retailer = Retailer.find_or_create_by(name: listing_data["retailer"])
        listing = product.listings.find_or_initialize_by({
          retailer: retailer,
          currency: listing_data["currency"],
          url: listing_data["url"],
          price: listing_data["price"]
          })
          
          if !listing.id
            listing.countries = listing_data["countries"]
            listing.sizes = listing_data["sizes"]
            listing.save
          end
        end
      end
    end
  end  
  
  User.create(email: "fluffy-butts-fake@gmail.com", password: "123456", role: :admin)
  
  upload_retailers()
  upload_brand_data("db/fixtures/AlvaBaby.json")
  upload_brand_data("db/fixtures/Bambino Mio.json")
  upload_brand_data("db/fixtures/Blueberry.json")
  upload_brand_data("db/fixtures/bumGenius.json")
  upload_brand_data("db/fixtures/GroVia.json")
  upload_brand_data("db/fixtures/Thirsties.json")
  
  Tag.where(category: "TBD").each do |tag|
    tag.update(category: tag_categories_data[tag.name])
  end
  
  Tag.where(category: nil).each do |tag|
    tag.update(category: tag_categories_data[tag.name])
  end