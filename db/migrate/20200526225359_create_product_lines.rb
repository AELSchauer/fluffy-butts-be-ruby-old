class CreateProductLines < ActiveRecord::Migration[6.0]
  def change
    create_table :product_lines do |t|
      t.string  :name
      t.string  :name_insensitive
      t.integer :product_type
      t.json    :details

      t.references :brand, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
