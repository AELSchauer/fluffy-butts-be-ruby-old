require "json"

tag_categories_data = JSON.parse(File.read("db/fixtures/tag_categories.json"))

def upload_brand_data (brand_filename)
  brand_data = JSON.parse(File.read(brand_filename))
  brand = Brand.find_or_create_by({ name: brand_data["brand"], origin_country: brand_data["country_origin"] })
  brand.images.find_or_create_by(name: brand_data["brand"], link: "https://storage.cloud.google.com/fluffy-butts/#{brand.name.gsub(/ /,"%20")}/Logo.png")
  
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
    product_line = brand.product_lines.find_or_initialize_by({ name: product_line_data["name"] })
    if !product_line.id
      product_line.details = product_line_data["details"].to_json
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
        if brand.name == "Thirsties"
          natural_product_lines = [
            "Natural Newborn All In One -- Hook & Loop",
            "Natural Newborn All In One -- Snap",
            "Natural One Size All In One -- Hook & Loop",
            "Natural One Size All In One -- Snap",
            "Natural One Size Pocket -- Snap",
            "Natural One Size Pocket -- Hook & Loop",
            "Stay Dry Natural One Size All In One"
          ]
          if natural_product_lines.include? product_line.name
            if product_line.name ==  "Stay Dry Natural One Size All In One"
              product_line_name = product_line.name.gsub("Stay Dry ","") + " -- Snap"
            end
            product_line_name = (product_line_name || product_line.name).gsub("Natural ","")
          end
        end
        product_line_name = (product_line_name || product_line.name).gsub(/ /,"%20")
        # if Product.last.id == 702
        #   puts product_line.name
        #   puts product_line_name
        #   puts "https://storage.cloud.google.com/fluffy-butts/#{brand.name.gsub(/ /,"%20")}/#{product_line_name}/#{product.name.gsub(/ /,"%20")}.jpg"
        # end
        link = product_data["image_src"] || "https://storage.cloud.google.com/fluffy-butts/#{brand.name.gsub(/ /,"%20")}/#{product_line_name}/#{product.name.gsub(/ /,"%20")}.jpg"
        product.images.find_or_create_by(name: product_data["name"], link: link)
      end
      
      product_data["listings"].each do |listing_data|
        product.listings.find_or_create_by({
          company: listing_data["company"],
          currency: listing_data["currency"],
          link: listing_data["link"],
          price: listing_data["price"],
          quantity: listing_data["quantity"],
          listing_type: listing_data["type"]
          })
        end
      end
    end
  end
  
  
  User.create(email: "fluffy-butts-fake@gmail.com", password: "123456", role: :admin)
  
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