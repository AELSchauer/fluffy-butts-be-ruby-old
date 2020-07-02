class CompanyResource < JSONAPI::Resource
  attributes :name, :ships_to, :urls
end