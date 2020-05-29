class Api::V1::Admin::BrandsController < JSONAPI::ResourceController
  include TokenAuthenticatable
end
