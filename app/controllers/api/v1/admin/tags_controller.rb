class Api::V1::Admin::TagsController < JSONAPI::ResourceController
  include TokenAuthenticatable
end
