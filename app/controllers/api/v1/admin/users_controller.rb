class Api::V1::Admin::UsersController < JSONAPI::ResourceController
  include TokenAuthenticatable
end
