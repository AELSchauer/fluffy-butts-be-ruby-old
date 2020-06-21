class ProductResource < JSONAPI::Resource
  attributes :name
  has_one :brand
  has_one :pattern
  has_one :product_line
  has_many :images
  has_many :listings

  def self.sortable_fields(context)
    super + [:"brand.name", :"product_line.name"]
  end

  filters :id, :name
  filters :brand, :pattern, :product_line

  filter :'brands.name', apply: ->(records, names, _options) {
    names_str = names.sort.map { |v| "'#{v}'"}.join(', ')
    records.joins(:brand).where("brands.name IN (#{names_str})")
  }
  filter :'tags', apply: ->(records, ids, _options) {
    records.find_by_tag_ids(ids)
  }
  filter :'tags.name', apply: ->(records, names, _options) {
    Tag.where(name: names).group_by(&:category).each do |category, tags|
      records = records.find_by_tag_ids(tags.pluck(:id))
    end
    records
  }
end
