class Api::V1::Admin::ListingsController < JSONAPI::ResourceController
  include TokenAuthenticatable
end
