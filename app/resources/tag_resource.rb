class TagResource < JSONAPI::Resource
  attributes :name, :category

  paginator :none
end