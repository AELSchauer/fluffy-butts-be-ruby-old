class Api::Admin::BrandsController < JSONAPI::ResourceController
  before_action :authenticate_user!
end
