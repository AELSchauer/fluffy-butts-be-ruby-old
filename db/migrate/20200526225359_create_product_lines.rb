class CreateProductLines < ActiveRecord::Migration[6.0]
  def change
    create_table :product_lines do |t|
      t.string  :name
      t.string  :name_insensitive
      t.string  :display_order
      t.integer :product_type
      t.jsonb   :details

      t.references :brand, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
