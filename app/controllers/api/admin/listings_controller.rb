class Api::Admin::ListingsController < JSONAPI::ResourceController
  before_action :authenticate_user!
end
