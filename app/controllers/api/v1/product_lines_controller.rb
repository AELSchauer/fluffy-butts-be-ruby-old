class Api::V1::ProductLinesController < ApplicationController
  def index
    @product_lines = params[:brand_id] ? Brand.find(params[:brand_id]).product_lines : ProductLine.all
    render json: @product_lines
  end

  def show
    render json: ProductLine.find(params[:id])
  end
end
