class Api::V1::Admin::ProductLinesController < JSONAPI::ResourceController
  include TokenAuthenticatable
end
