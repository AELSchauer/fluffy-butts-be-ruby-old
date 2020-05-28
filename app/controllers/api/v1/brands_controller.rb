class Api::V1::BrandsController < ApplicationController
  def index
    render json: Brand.all
  end

  def show
    render json: Brand.find(params[:id])
  end
end
