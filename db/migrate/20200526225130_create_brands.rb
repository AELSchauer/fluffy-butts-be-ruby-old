class CreateBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :brands do |t|
      t.string :name,             null: false
      t.string :name_insensitive, null: false
      t.string :origin_country

      t.timestamps null: false
    end
  end
end
