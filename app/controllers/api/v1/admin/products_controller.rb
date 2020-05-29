class Api::V1::Admin::ProductsController < JSONAPI::ResourceController
  include TokenAuthenticatable
end
