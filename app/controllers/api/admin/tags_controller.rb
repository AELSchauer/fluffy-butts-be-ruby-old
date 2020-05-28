class Api::Admin::TagsController < JSONAPI::ResourceController
  before_action :authenticate_user!
end
