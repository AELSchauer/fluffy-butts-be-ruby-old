class ProductResource < JSONAPI::Resource
  attributes :name, :product_line_data, :available
  has_one :brand
  has_one :pattern
  has_one :product_line
  has_many :images
  has_many :listings

  filters :id, :name, :available
  filters :brand, :pattern, :product_line
  
  def self.sortable_fields(context)
    super + [:"brand.name", :"product_line.name"]
  end
  
  filter :'available', apply: ->(records, available, _options) {
    records.find_by_available(available[0] === "true")
  }
  
  filter :'brand.name', apply: ->(records, names, _options) {
    names_str = names.sort.map { |name| "'#{name}'"}.join(', ')
    records.joins(:brand).where("brands.name IN (#{names_str})")
  }
  
  filter :'product_line.name', apply: ->(records, names, _options) {
    names_str = names.sort.map { |name| "'#{name}'"}.join(', ')
    records.joins(:product_line).where("product_lines.name IN (#{names_str})")
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
