
class Api::V1::SpecialtyServesController < ApplicationController
  def brand_product_lines
    brand_name = params.try(:[], "filter").try(:[], "brand.name")
    json = {}

    if not brand_name.nil?
      @products = Brand.find_by(name: brand_name).product_lines.map do | product_line |
        product_line.default_product || product_line.products.first
      end
      json = serialize_models(@products, include: ['images', 'product-line', 'product-line.brand', 'product-line.tags'])
    end

    render json: json
  end
end
