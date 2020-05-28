class Api::Admin::ProductsController < JSONAPI::ResourceController
  before_action :authenticate_user!
end
