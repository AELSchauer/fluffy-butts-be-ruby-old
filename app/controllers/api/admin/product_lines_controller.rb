class Api::Admin::ProductLinesController < JSONAPI::ResourceController
  before_action :authenticate_user!
end
