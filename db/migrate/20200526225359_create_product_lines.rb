class CreateProductLines < ActiveRecord::Migration[6.0]
  def change
    create_table :product_lines do |t|
      t.integer :product_type
      t.string :name
      t.json :sizing
      t.json :dimensions
      t.references :brand, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
